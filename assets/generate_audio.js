const fs = require('fs');
const path = require('path');

function createWavBuffer(sampleRate, durationSeconds, generateSample) {
  const numSamples = Math.floor(sampleRate * durationSeconds);
  const blockAlign = 2; // 1 channel * 16 bit
  const byteRate = sampleRate * blockAlign;
  const dataSize = numSamples * blockAlign;
  const buffer = Buffer.alloc(44 + dataSize);

  // RIFF header
  buffer.write('RIFF', 0);
  buffer.writeUInt32LE(36 + dataSize, 4);
  buffer.write('WAVE', 8);

  // fmt subchunk
  buffer.write('fmt ', 12);
  buffer.writeUInt32LE(16, 16);
  buffer.writeUInt16LE(1, 20); // PCM
  buffer.writeUInt16LE(1, 22); // Mono
  buffer.writeUInt32LE(sampleRate, 24);
  buffer.writeUInt32LE(byteRate, 28);
  buffer.writeUInt16LE(blockAlign, 32);
  buffer.writeUInt16LE(16, 34);

  // data subchunk
  buffer.write('data', 36);
  buffer.writeUInt32LE(dataSize, 40);

  for (let i = 0; i < numSamples; i++) {
    const t = i / sampleRate;
    const s = Math.max(-1, Math.min(1, generateSample(t, durationSeconds, i)));
    const intSample = Math.floor(s * 32767);
    buffer.writeInt16LE(intSample, 44 + i * 2);
  }

  return buffer;
}

// Single, clean, crisp SWAP sound (exactly ONE unified sound, 0.08s)
const sampleRate = 44100;
const swapDuration = 0.085;

const slideBuffer = createWavBuffer(sampleRate, swapDuration, (t, dur, i) => {
  // Exponential decay envelope (fast, punchy, zero tail)
  const env = Math.exp(-t * 45);
  
  // Smooth unified pitch drop: sweeps from 620 Hz down to 260 Hz
  const freq = 620 - (t / dur) * 360;
  
  // Clean fundamental tone + soft warm harmonic
  const tone = Math.sin(2 * Math.PI * freq * t) * 0.75 + Math.sin(2 * Math.PI * (freq * 1.5) * t) * 0.25;
  
  // Subtle initial transient snap (only in first 8ms)
  let initialSnap = 0;
  if (t < 0.008) {
    const snapEnv = 1.0 - (t / 0.008);
    initialSnap = Math.sin(2 * Math.PI * 1800 * t) * snapEnv * 0.4;
  }

  return (tone * 0.75 + initialSnap) * env * 0.85;
});

fs.writeFileSync(path.join(__dirname, 'audio', 'slide.wav'), slideBuffer);
console.log('Single clean swap sound created: slide.wav');

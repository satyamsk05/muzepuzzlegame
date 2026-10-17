const fs = require('fs');
const path = require('path');

const outDir = path.join(__dirname, 'icons');

// Clean, modern 24x24 stroke SVG icons in the requested format
const icons = {
  // 1. Play icon
  'play.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M6 4.5L19 12L6 19.5V4.5Z" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="#FFFFFF"/>
</svg>`,

  // 2. Info / How to play icon
  'info.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="12" cy="12" r="9" stroke="#334155" stroke-width="2"/>
  <path d="M12 11V16" stroke="#334155" stroke-width="2" stroke-linecap="round"/>
  <circle cx="12" cy="8" r="1" fill="#334155"/>
</svg>`,

  // 3. Sound On icon
  'sound_on.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M4 14V10C4 9.44772 4.44772 9 5 9H8L13 5V19L8 15H5C4.44772 15 4 14.5523 4 14Z" stroke="#1E293B" stroke-width="2" stroke-linejoin="round"/>
  <path d="M16 9C17.3333 10.3333 17.3333 13.6667 16 15" stroke="#1E293B" stroke-width="2" stroke-linecap="round"/>
  <path d="M19 6C21.6667 8.66667 21.6667 15.3333 19 18" stroke="#1E293B" stroke-width="2" stroke-linecap="round"/>
</svg>`,

  // 4. Sound Off / Mute icon
  'sound_off.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M4 14V10C4 9.44772 4.44772 9 5 9H8L13 5V19L8 15H5C4.44772 15 4 14.5523 4 14Z" stroke="#64748B" stroke-width="2" stroke-linejoin="round"/>
  <path d="M16 10L21 15" stroke="#EF4444" stroke-width="2" stroke-linecap="round"/>
  <path d="M21 10L16 15" stroke="#EF4444" stroke-width="2" stroke-linecap="round"/>
</svg>`,

  // 5. Back Arrow icon
  'back.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M15 19L8 12L15 5" stroke="#1E293B" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>`,

  // 6. Reset / Reload icon
  'reload.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M4 12C4 7.58172 7.58172 4 12 4C15.8559 4 19.0768 6.72123 19.822 10.345" stroke="#B45309" stroke-width="2" stroke-linecap="round"/>
  <path d="M20 12C20 16.4183 16.4183 20 12 20C8.14411 20 4.92318 17.2788 4.17798 13.655" stroke="#B45309" stroke-width="2" stroke-linecap="round"/>
  <path d="M20 5V10H15" stroke="#B45309" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M4 19V14H9" stroke="#B45309" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>`,

  // 7. Shuffle icon
  'shuffle.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M16 4H20V8" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M4 20L9 15L14 10L20 4" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M16 20H20V16" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M4 4L9 9L11.5 11.5" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M14.5 14.5L20 20" stroke="#FFFFFF" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>`,

  // 8. Lock icon (for locked levels)
  'lock.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="5" y="11" width="14" height="10" rx="3" stroke="#94A3B8" stroke-width="2"/>
  <path d="M8 11V7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7V11" stroke="#94A3B8" stroke-width="2" stroke-linecap="round"/>
  <circle cx="12" cy="16" r="1.5" fill="#94A3B8"/>
</svg>`,

  // 9. Checkmark icon (for completed levels)
  'check.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M5 13L9 17L19 7" stroke="#047857" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>`,

  // 10. Timer / Stopwatch icon
  'timer.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <circle cx="12" cy="13" r="8" stroke="#2563EB" stroke-width="2"/>
  <path d="M12 9V13L15 15" stroke="#2563EB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M10 2H14" stroke="#2563EB" stroke-width="2" stroke-linecap="round"/>
</svg>`,

  // 11. Moves / Sliding icon
  'moves.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect x="3" y="3" width="7" height="7" rx="1.5" stroke="#2563EB" stroke-width="2"/>
  <rect x="14" y="3" width="7" height="7" rx="1.5" stroke="#2563EB" stroke-width="2"/>
  <rect x="3" y="14" width="7" height="7" rx="1.5" stroke="#2563EB" stroke-width="2"/>
  <path d="M17 14L17 21M17 21L14 18M17 21L20 18" stroke="#2563EB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>`,

  // 12. Trophy / Victory Award icon
  'trophy.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M7 4H17V10C17 12.7614 14.7614 15 12 15C9.23858 15 7 12.7614 7 10V4Z" stroke="#D97706" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M7 6H4C3.44772 6 3 6.44772 3 7V8C3 10.2091 4.79086 12 7 12V12" stroke="#D97706" stroke-width="2" stroke-linecap="round"/>
  <path d="M17 6H20C20.5523 6 21 6.44772 21 7V8C21 10.2091 19.2091 12 17 12V12" stroke="#D97706" stroke-width="2" stroke-linecap="round"/>
  <path d="M12 15V19" stroke="#D97706" stroke-width="2" stroke-linecap="round"/>
  <path d="M8 21H16" stroke="#D97706" stroke-width="2" stroke-linecap="round"/>
</svg>`,

  // 13. Puzzle Toy emblem for home screen
  'puzzle.svg': `<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M4 11V6C4 4.89543 4.89543 4 6 4H10C10 5.10457 10.8954 6 12 6C13.1046 6 14 5.10457 14 4H18C19.1046 4 20 4.89543 20 6V10C18.8954 10 18 10.8954 18 12C18 13.1046 18.8954 14 20 14V18C20 19.1046 19.1046 20 18 20H14C14 18.8954 13.1046 18 12 18C10.8954 18 10 18.8954 10 20H6C4.89543 20 4 19.1046 4 18V14C5.10457 14 6 13.1046 6 12C6 10.8954 5.10457 10 4 10V11Z" stroke="#2563EB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="#EBF4FF"/>
</svg>`
};

for (const [filename, content] of Object.entries(icons)) {
  fs.writeFileSync(path.join(outDir, filename), content.trim());
  console.log('Created icon: ' + filename);
}
console.log('All 13 clean SVG icons created successfully.');

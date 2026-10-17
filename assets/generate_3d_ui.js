const fs = require('fs');
const path = require('path');

const uiDir = path.join(__dirname, 'ui');
if (!fs.existsSync(uiDir)) {
  fs.mkdirSync(uiDir, { recursive: true });
}

const assets = {
  // 1. 3D Glossy Star
  'star_3d.svg': `<svg viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="starGrad" x1="24" y1="2" x2="24" y2="46" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FFE066"/>
      <stop offset="50%" stop-color="#FFB800"/>
      <stop offset="100%" stop-color="#E68A00"/>
    </linearGradient>
    <linearGradient id="starHighlight" x1="24" y1="4" x2="24" y2="24" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FFFFFF" stop-opacity="0.8"/>
      <stop offset="100%" stop-color="#FFE066" stop-opacity="0"/>
    </linearGradient>
    <filter id="starShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="4" stdDeviation="3" flood-color="#B36200" flood-opacity="0.5"/>
    </filter>
  </defs>
  <!-- Base Star with Shadow -->
  <path filter="url(#starShadow)" d="M24 3L29.5 16.5L44 17.5L33 27L36.5 41L24 33.5L11.5 41L15 27L4 17.5L18.5 16.5L24 3Z" fill="url(#starGrad)"/>
  <!-- 3D Bevel Facets -->
  <path d="M24 3L24 33.5L11.5 41L15 27L4 17.5L18.5 16.5L24 3Z" fill="#000000" fill-opacity="0.12"/>
  <!-- Specular Top Glow -->
  <path d="M24 5L28 16L39 17L30.5 24L24 20L17.5 24L9 17L20 16L24 5Z" fill="url(#starHighlight)"/>
</svg>`,

  // 2. 3D Empty/Muted Star
  'star_empty.svg': `<svg viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="emptyStarGrad" x1="24" y1="2" x2="24" y2="46" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#64748B"/>
      <stop offset="100%" stop-color="#334155"/>
    </linearGradient>
  </defs>
  <path d="M24 3L29.5 16.5L44 17.5L33 27L36.5 41L24 33.5L11.5 41L15 27L4 17.5L18.5 16.5L24 3Z" fill="url(#emptyStarGrad)" fill-opacity="0.6"/>
  <path d="M24 3L24 33.5L11.5 41L15 27L4 17.5L18.5 16.5L24 3Z" fill="#000000" fill-opacity="0.2"/>
</svg>`,

  // 3. Nav Rocket Icon (3D glossy feel)
  'nav_rocket.svg': `<svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="rocketBody" x1="16" y1="4" x2="16" y2="28" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#60A5FA"/>
      <stop offset="100%" stop-color="#3B82F6"/>
    </linearGradient>
  </defs>
  <path d="M16 3C11 7 9 14 9 20C9 23 11 25 14 25H18C21 25 23 23 23 20C23 14 21 7 16 3Z" fill="url(#rocketBody)"/>
  <circle cx="16" cy="13" r="3.5" fill="#E0F2FE" stroke="#0284C7" stroke-width="1.5"/>
  <path d="M9 18L4 21C4 21 5 25 8 26L10 23" fill="#38BDF8"/>
  <path d="M23 18L28 21C28 21 27 25 24 26L22 23" fill="#38BDF8"/>
  <path d="M14 25L16 29L18 25" fill="#F97316"/>
  <path d="M15 25L16 27.5L17 25" fill="#FDE047"/>
</svg>`,

  // 4. Nav Book Icon ("Learn")
  'nav_book.svg': `<svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="bookGrad" x1="16" y1="6" x2="16" y2="26" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#34D399"/>
      <stop offset="100%" stop-color="#059669"/>
    </linearGradient>
  </defs>
  <path d="M16 10C13 7 6 7 4 8V24C6 23 13 23 16 26C19 23 26 23 28 24V8C26 7 19 7 16 10Z" fill="url(#bookGrad)"/>
  <path d="M16 10V26" stroke="#064E3B" stroke-width="1.8"/>
  <path d="M7 12C9 11.5 12 11.5 14 12.5" stroke="#A7F3D0" stroke-width="1.2" stroke-linecap="round"/>
  <path d="M7 16C9 15.5 12 15.5 14 16.5" stroke="#A7F3D0" stroke-width="1.2" stroke-linecap="round"/>
</svg>`,

  // 5. Nav Chart Icon ("Progress")
  'nav_chart.svg': `<svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="chartGrad" x1="16" y1="6" x2="16" y2="26" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#F43F5E"/>
      <stop offset="100%" stop-color="#BE123C"/>
    </linearGradient>
  </defs>
  <rect x="6" y="16" width="5" height="10" rx="2.5" fill="url(#chartGrad)"/>
  <rect x="13.5" y="10" width="5" height="16" rx="2.5" fill="url(#chartGrad)"/>
  <rect x="21" y="6" width="5" height="20" rx="2.5" fill="url(#chartGrad)"/>
</svg>`,

  // 6. Nav Profile Icon ("Profile")
  'nav_profile.svg': `<svg viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="profileGrad" x1="16" y1="5" x2="16" y2="27" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#A78BFA"/>
      <stop offset="100%" stop-color="#6D28D9"/>
    </linearGradient>
  </defs>
  <circle cx="16" cy="11" r="5" fill="url(#profileGrad)"/>
  <path d="M8 25C8 20.5 11.5 18 16 18C20.5 18 24 20.5 24 25C24 26 23 27 22 27H10C9 27 8 26 8 25Z" fill="url(#profileGrad)"/>
</svg>`,

  // 7. Speech Bubble
  'speech_bubble.svg': `<svg viewBox="0 0 160 70" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <filter id="bubbleDrop" x="-10%" y="-10%" width="120%" height="130%">
      <feDropShadow dx="0" dy="4" stdDeviation="4" flood-color="#000000" flood-opacity="0.3"/>
    </filter>
  </defs>
  <path filter="url(#bubbleDrop)" d="M25 4C13.402 4 4 13.402 4 25C4 36.598 13.402 46 25 46H120L145 60L135 46H135C146.598 46 156 36.598 156 25C156 13.402 146.598 4 135 4H25Z" fill="#FFFFFF"/>
</svg>`,

  // 8. 3D Beveled Level Node (Completed/Unlocked)
  'level_node_unlocked.svg': `<svg viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="nodeBase" cx="50%" cy="30%" r="70%">
      <stop offset="0%" stop-color="#70A6FF"/>
      <stop offset="60%" stop-color="#4D7DF8"/>
      <stop offset="100%" stop-color="#2548C9"/>
    </radialGradient>
    <filter id="nodeShadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="8" stdDeviation="6" flood-color="#0F172A" flood-opacity="0.6"/>
    </filter>
  </defs>
  <!-- Outer deep bottom rim for 3D thickness -->
  <circle cx="60" cy="66" r="48" fill="#1E3A8A"/>
  <!-- Main convex button face -->
  <circle filter="url(#nodeShadow)" cx="60" cy="58" r="48" fill="url(#nodeBase)"/>
  <!-- Glossy top specular crest -->
  <ellipse cx="60" cy="32" rx="34" ry="16" fill="#FFFFFF" fill-opacity="0.35"/>
</svg>`,

  // 9. 3D Beveled Level Node (Current Active with Glowing Ring)
  'level_node_current.svg': `<svg viewBox="0 0 140 140" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="currNodeBase" cx="50%" cy="30%" r="70%">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="70%" stop-color="#EEF2FF"/>
      <stop offset="100%" stop-color="#CBD5E1"/>
    </radialGradient>
    <filter id="ringGlow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="0" stdDeviation="6" flood-color="#818CF8" flood-opacity="0.9"/>
    </filter>
  </defs>
  <!-- Glowing outer circular aura -->
  <circle cx="70" cy="70" r="64" stroke="#818CF8" stroke-width="5" stroke-dasharray="14 8" filter="url(#ringGlow)" fill="none"/>
  <!-- 3D bottom rim -->
  <circle cx="70" cy="76" r="50" fill="#94A3B8"/>
  <!-- White glossy button face -->
  <circle cx="70" cy="68" r="50" fill="url(#currNodeBase)"/>
  <ellipse cx="70" cy="42" rx="36" ry="16" fill="#FFFFFF" fill-opacity="0.8"/>
</svg>`,

  // 10. 3D Beveled Level Node (Locked)
  'level_node_locked.svg': `<svg viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <radialGradient id="lockedBase" cx="50%" cy="30%" r="70%">
      <stop offset="0%" stop-color="#334155"/>
      <stop offset="100%" stop-color="#1E293B"/>
    </radialGradient>
  </defs>
  <circle cx="60" cy="65" r="46" fill="#0F172A"/>
  <circle cx="60" cy="58" r="46" fill="url(#lockedBase)"/>
  <ellipse cx="60" cy="34" rx="30" ry="14" fill="#FFFFFF" fill-opacity="0.08"/>
  <!-- Silver Lock icon in center -->
  <rect x="50" y="55" width="20" height="15" rx="3" fill="#64748B"/>
  <path d="M54 55V50C54 46.686 56.686 44 60 44C63.314 44 66 46.686 66 50V55" stroke="#94A3B8" stroke-width="3" stroke-linecap="round" fill="none"/>
</svg>`,

  // 11. Soft Space Cloud
  'space_cloud.svg': `<svg viewBox="0 0 200 100" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M30 70C20 70 10 60 10 50C10 40 20 32 30 32C33 18 48 8 65 8C85 8 98 20 100 28C108 22 120 22 128 28C138 18 155 18 165 28C182 30 190 45 190 55C190 65 180 70 170 70H30Z" fill="#1E293B" fill-opacity="0.45"/>
</svg>`
};

for (const [filename, content] of Object.entries(assets)) {
  fs.writeFileSync(path.join(uiDir, filename), content.trim());
  console.log('Created UI asset: ' + filename);
}
console.log('All 3D-styled UI assets successfully created.');

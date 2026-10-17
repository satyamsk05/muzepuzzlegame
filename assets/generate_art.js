const fs = require('fs');
const path = require('path');

const outDir = path.join(__dirname, 'images');

const svgs = {
  // Level 2: Birds
  'level_2.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <defs>
      <linearGradient id="sky2" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#89f7fe"/>
        <stop offset="100%" stop-color="#66a6ff"/>
      </linearGradient>
    </defs>
    <rect width="650" height="390" fill="url(#sky2)"/>
    <!-- Distant trees -->
    <path d="M 0 390 L 0 310 Q 150 260 300 290 Q 450 250 650 300 L 650 390 Z" fill="#2d6a4f"/>
    <!-- Tree branch -->
    <path d="M -10 240 Q 180 200 380 220 Q 520 230 660 170 L 660 210 Q 500 270 350 260 Q 150 250 -10 280 Z" fill="#5c4033"/>
    <path d="M 180 220 Q 240 140 310 130 Q 320 150 260 190 Q 220 220 180 220 Z" fill="#5c4033"/>
    <!-- Leaves -->
    <ellipse cx="140" cy="190" rx="35" ry="18" fill="#52b788" transform="rotate(-25 140 190)"/>
    <ellipse cx="280" cy="130" rx="40" ry="20" fill="#74c69d" transform="rotate(15 280 130)"/>
    <ellipse cx="360" cy="150" rx="35" ry="16" fill="#40916c" transform="rotate(-10 360 150)"/>
    <ellipse cx="490" cy="180" rx="45" ry="22" fill="#52b788" transform="rotate(30 490 180)"/>
    <ellipse cx="600" cy="160" rx="40" ry="18" fill="#74c69d" transform="rotate(-15 600 160)"/>
    <!-- Red Bird (Left) -->
    <g transform="translate(130, 160)">
      <ellipse cx="0" cy="0" rx="32" ry="24" fill="#e63946"/>
      <circle cx="22" cy="-14" r="16" fill="#e63946"/>
      <circle cx="27" cy="-16" r="4" fill="#ffffff"/>
      <circle cx="28" cy="-16" r="2" fill="#111111"/>
      <polygon points="36,-14 50,-10 35,-6" fill="#f4a261"/>
      <ellipse cx="-10" cy="2" rx="20" ry="12" fill="#d90429" transform="rotate(-15 -10 2)"/>
      <polygon points="-30,6 -55,16 -32,-4" fill="#9b2226"/>
      <!-- Little feet -->
      <line x1="-5" y1="24" x2="-5" y2="42" stroke="#f4a261" stroke-width="3"/>
      <line x1="8" y1="24" x2="8" y2="42" stroke="#f4a261" stroke-width="3"/>
    </g>
    <!-- Blue Bird (Right) -->
    <g transform="translate(430, 180)">
      <ellipse cx="0" cy="0" rx="35" ry="26" fill="#0077b6"/>
      <circle cx="-24" cy="-16" r="18" fill="#0077b6"/>
      <circle cx="-30" cy="-18" r="4" fill="#ffffff"/>
      <circle cx="-31" cy="-18" r="2" fill="#111111"/>
      <polygon points="-40,-16 -54,-12 -39,-8" fill="#ffb703"/>
      <ellipse cx="12" cy="2" rx="22" ry="14" fill="#023e8a" transform="rotate(15 12 2)"/>
      <polygon points="32,6 58,18 35,-4" fill="#03045e"/>
      <line x1="-6" y1="26" x2="-6" y2="44" stroke="#ffb703" stroke-width="3"/>
      <line x1="10" y1="26" x2="10" y2="44" stroke="#ffb703" stroke-width="3"/>
    </g>
    <!-- Berries -->
    <circle cx="240" cy="180" r="7" fill="#d62828"/><circle cx="250" cy="186" r="6" fill="#d62828"/><circle cx="242" cy="194" r="6" fill="#d62828"/>
    <circle cx="480" cy="210" r="7" fill="#d62828"/><circle cx="490" cy="218" r="6" fill="#d62828"/>
  </svg>`,

  // Level 3: Butterfly garden
  'level_3.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <defs>
      <linearGradient id="bg3" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#fff1eb"/>
        <stop offset="100%" stop-color="#ace0f9"/>
      </linearGradient>
    </defs>
    <rect width="650" height="390" fill="url(#bg3)"/>
    <!-- Grass field -->
    <path d="M 0 260 Q 200 240 400 270 Q 550 250 650 260 L 650 390 L 0 390 Z" fill="#55a630"/>
    <!-- Sun -->
    <circle cx="90" cy="70" r="40" fill="#ffb703" opacity="0.8"/>
    <!-- Big Flowers -->
    <g transform="translate(120, 290)">
      <line x1="0" y1="0" x2="0" y2="90" stroke="#2d6a4f" stroke-width="8"/>
      <circle cx="-25" cy="-10" r="18" fill="#ff4d6d"/><circle cx="25" cy="-10" r="18" fill="#ff4d6d"/>
      <circle cx="0" cy="-30" r="18" fill="#ff4d6d"/><circle cx="-16" cy="18" r="18" fill="#ff4d6d"/><circle cx="16" cy="18" r="18" fill="#ff4d6d"/>
      <circle cx="0" cy="0" r="15" fill="#ffb703"/>
    </g>
    <g transform="translate(530, 280)">
      <line x1="0" y1="0" x2="0" y2="100" stroke="#2d6a4f" stroke-width="8"/>
      <circle cx="-25" cy="-10" r="18" fill="#9d4edd"/><circle cx="25" cy="-10" r="18" fill="#9d4edd"/>
      <circle cx="0" cy="-30" r="18" fill="#9d4edd"/><circle cx="-16" cy="18" r="18" fill="#9d4edd"/><circle cx="16" cy="18" r="18" fill="#9d4edd"/>
      <circle cx="0" cy="0" r="15" fill="#ffea00"/>
    </g>
    <!-- Giant Central Butterfly -->
    <g transform="translate(325, 160)">
      <!-- Left wings -->
      <path d="M 0 -10 C -70 -90 -130 -40 -110 10 C -100 40 -40 30 0 10 Z" fill="#ff758f"/>
      <path d="M 0 10 C -90 40 -80 110 -20 80 C 0 60 0 20 0 10 Z" fill="#ffb3c1"/>
      <!-- Right wings -->
      <path d="M 0 -10 C 70 -90 130 -40 110 10 C 100 40 40 30 0 10 Z" fill="#ff758f"/>
      <path d="M 0 10 C 90 40 80 110 20 80 C 0 60 0 20 0 10 Z" fill="#ffb3c1"/>
      <!-- Wing spots -->
      <circle cx="-65" cy="-20" r="14" fill="#7209b7"/>
      <circle cx="65" cy="-20" r="14" fill="#7209b7"/>
      <circle cx="-45" cy="50" r="10" fill="#3a0ca3"/>
      <circle cx="45" cy="50" r="10" fill="#3a0ca3"/>
      <!-- Body -->
      <ellipse cx="0" cy="20" rx="8" ry="42" fill="#2b2d42"/>
      <circle cx="0" cy="-26" r="10" fill="#2b2d42"/>
      <!-- Antennae -->
      <path d="M -3 -35 Q -25 -65 -35 -50" stroke="#2b2d42" stroke-width="3" fill="none"/>
      <path d="M 3 -35 Q 25 -65 35 -50" stroke="#2b2d42" stroke-width="3" fill="none"/>
    </g>
  </svg>`,

  // Level 4: Farm animals
  'level_4.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <defs>
      <linearGradient id="sky4" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#70e000"/>
        <stop offset="0%" stop-color="#38b000"/>
      </linearGradient>
    </defs>
    <!-- Sky & Sun -->
    <rect width="650" height="230" fill="#90e0ef"/>
    <circle cx="560" cy="60" r="40" fill="#ffb703"/>
    <!-- Hills -->
    <path d="M 0 230 Q 300 170 650 220 L 650 390 L 0 390 Z" fill="#38b000"/>
    <!-- Red Barn on Right -->
    <polygon points="430,220 590,220 590,120 510,70 430,120" fill="#d90429"/>
    <polygon points="415,125 510,65 605,125 595,135 510,80 425,135" fill="#f8f9fa"/>
    <rect x="480" y="150" width="60" height="70" fill="#ffffff"/>
    <line x1="480" y1="150" x2="540" y2="220" stroke="#d90429" stroke-width="4"/>
    <line x1="540" y1="150" x2="480" y2="220" stroke="#d90429" stroke-width="4"/>
    <!-- Wooden Fence -->
    <line x1="20" y1="260" x2="420" y2="260" stroke="#e09f3e" stroke-width="6"/>
    <line x1="20" y1="285" x2="420" y2="285" stroke="#e09f3e" stroke-width="6"/>
    <rect x="50" y="245" width="12" height="55" rx="3" fill="#9e2a2b"/>
    <rect x="150" y="245" width="12" height="55" rx="3" fill="#9e2a2b"/>
    <rect x="250" y="245" width="12" height="55" rx="3" fill="#9e2a2b"/>
    <rect x="350" y="245" width="12" height="55" rx="3" fill="#9e2a2b"/>
    <!-- Friendly Cow (Center Left) -->
    <g transform="translate(180, 270)">
      <ellipse cx="0" cy="0" rx="60" ry="40" fill="#f8f9fa" stroke="#333" stroke-width="2"/>
      <ellipse cx="-20" cy="-10" rx="18" ry="14" fill="#2b2d42"/>
      <ellipse cx="25" cy="10" rx="16" ry="12" fill="#2b2d42"/>
      <!-- Legs -->
      <rect x="-45" y="30" width="12" height="40" fill="#f8f9fa" stroke="#333" stroke-width="2"/>
      <rect x="-20" y="30" width="12" height="40" fill="#f8f9fa" stroke="#333" stroke-width="2"/>
      <rect x="15" y="30" width="12" height="40" fill="#f8f9fa" stroke="#333" stroke-width="2"/>
      <rect x="40" y="30" width="12" height="40" fill="#f8f9fa" stroke="#333" stroke-width="2"/>
      <!-- Head -->
      <circle cx="-65" cy="-20" r="28" fill="#f8f9fa" stroke="#333" stroke-width="2"/>
      <ellipse cx="-78" cy="-14" rx="16" ry="12" fill="#ffb4a2"/>
      <circle cx="-82" cy="-16" r="3" fill="#6d6875"/>
      <circle cx="-74" cy="-16" r="3" fill="#6d6875"/>
      <circle cx="-60" cy="-28" r="4" fill="#2b2d42"/>
      <!-- Horns & Ears -->
      <polygon points="-58,-46 -52,-38 -64,-38" fill="#f4a261"/>
      <polygon points="-72,-46 -66,-38 -78,-38" fill="#f4a261"/>
    </g>
  </svg>`,

  // Level 5: Ocean life
  'level_5.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <defs>
      <linearGradient id="ocean5" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#00b4d8"/>
        <stop offset="60%" stop-color="#0077b6"/>
        <stop offset="100%" stop-color="#03045e"/>
      </linearGradient>
    </defs>
    <rect width="650" height="390" fill="url(#ocean5)"/>
    <!-- Sandy bottom with corals -->
    <path d="M 0 350 Q 200 330 400 350 Q 550 330 650 340 L 650 390 L 0 390 Z" fill="#e9c46a"/>
    <path d="M 30 360 Q 20 280 60 260 Q 70 300 80 360" fill="#f72585"/>
    <path d="M 540 360 Q 580 270 550 250 Q 520 290 510 360" fill="#7209b7"/>
    <!-- Bubbles -->
    <circle cx="210" cy="220" r="8" fill="#caf0f8" opacity="0.6"/>
    <circle cx="216" cy="180" r="12" fill="#caf0f8" opacity="0.6"/>
    <circle cx="212" cy="120" r="16" fill="#caf0f8" opacity="0.6"/>
    <!-- Cute Clownfish / Tropical Fish (Center) -->
    <g transform="translate(320, 180)">
      <ellipse cx="0" cy="0" rx="75" ry="48" fill="#ff7b00"/>
      <!-- Tail -->
      <polygon points="-65,0 -120,-35 -105,0 -120,35" fill="#ff7b00"/>
      <polygon points="-75,0 -115,-25 -105,0 -115,25" fill="#ffffff"/>
      <!-- White stripes -->
      <path d="M -15 -46 Q -5 0 -15 46 L -3 46 Q 7 0 -3 -46 Z" fill="#ffffff"/>
      <path d="M 25 -42 Q 35 0 25 42 L 35 38 Q 45 0 35 -38 Z" fill="#ffffff"/>
      <!-- Fins -->
      <path d="M 5 -46 Q 30 -70 50 -42 Z" fill="#ff7b00"/>
      <path d="M 10 46 Q 30 70 45 42 Z" fill="#ff7b00"/>
      <!-- Eye -->
      <circle cx="45" cy="-12" r="10" fill="#ffffff"/>
      <circle cx="47" cy="-12" r="5" fill="#111111"/>
    </g>
    <!-- Starfish -->
    <polygon points="180,335 186,350 202,352 190,362 194,378 180,368 166,378 170,362 158,352 174,350" fill="#e76f51"/>
  </svg>`,

  // Level 6: Space scene
  'level_6.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <defs>
      <linearGradient id="space6" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" stop-color="#0b091a"/>
        <stop offset="50%" stop-color="#161b33"/>
        <stop offset="100%" stop-color="#2a0845"/>
      </linearGradient>
    </defs>
    <rect width="650" height="390" fill="url(#space6)"/>
    <!-- Stars -->
    <circle cx="50" cy="40" r="2" fill="#ffffff"/><circle cx="120" cy="90" r="3" fill="#ffe066"/>
    <circle cx="200" cy="30" r="1.5" fill="#ffffff"/><circle cx="280" cy="80" r="2" fill="#ffffff"/>
    <circle cx="350" cy="40" r="3" fill="#ffe066"/><circle cx="480" cy="50" r="2" fill="#ffffff"/>
    <circle cx="580" cy="110" r="2" fill="#ffffff"/><circle cx="100" cy="300" r="2" fill="#ffffff"/>
    <circle cx="440" cy="330" r="2.5" fill="#ffffff"/><circle cx="600" cy="280" r="1.5" fill="#ffffff"/>
    <!-- Saturn-like Ringed Planet (Top Right) -->
    <g transform="translate(490, 110)">
      <ellipse cx="0" cy="0" rx="90" ry="24" fill="none" stroke="#f4a261" stroke-width="12" transform="rotate(-20)" opacity="0.8"/>
      <circle cx="0" cy="0" r="48" fill="#e76f51"/>
      <ellipse cx="0" cy="0" rx="90" ry="24" fill="none" stroke="#e9c46a" stroke-width="8" transform="rotate(-20)" stroke-dasharray="80 300"/>
    </g>
    <!-- Rocket Ship (Center) -->
    <g transform="translate(230, 210) rotate(-35)">
      <!-- Flame -->
      <polygon points="-16,70 16,70 0,120" fill="#ffb703"/>
      <polygon points="-8,70 8,70 0,100" fill="#d90429"/>
      <!-- Body -->
      <path d="M 0 -80 Q 35 -20 30 70 L -30 70 Q -35 -20 0 -80 Z" fill="#f8f9fa"/>
      <!-- Red nose -->
      <path d="M 0 -80 Q 20 -45 23 -35 L -23 -35 Q -20 -45 0 -80 Z" fill="#d90429"/>
      <!-- Fins -->
      <polygon points="-30,30 -60,75 -30,65" fill="#d90429"/>
      <polygon points="30,30 60,75 30,65" fill="#d90429"/>
      <!-- Porthole Window -->
      <circle cx="0" cy="-5" r="18" fill="#00b4d8" stroke="#ced4da" stroke-width="5"/>
      <circle cx="-4" cy="-8" r="5" fill="#ffffff"/>
    </g>
  </svg>`,

  // Level 7: Train
  'level_7.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <rect width="650" height="390" fill="#a0c4ff"/>
    <!-- Mountains in background -->
    <polygon points="-20,260 140,110 280,260" fill="#588157"/>
    <polygon points="200,260 380,80 540,260" fill="#3a5a40"/>
    <polygon points="450,260 560,140 680,260" fill="#588157"/>
    <!-- Snowcaps -->
    <polygon points="380,80 350,120 410,120" fill="#f8f9fa"/>
    <!-- Ground -->
    <rect y="260" width="650" height="130" fill="#a7c957"/>
    <!-- Rail Tracks -->
    <line x1="0" y1="315" x2="650" y2="315" stroke="#495057" stroke-width="6"/>
    <line x1="0" y1="330" x2="650" y2="330" stroke="#495057" stroke-width="6"/>
    <!-- Sleepers -->
    ${Array.from({length: 22}).map((_, i) => `<line x1="${i*30 + 10}" y1="310" x2="${i*30 + 10}" y2="335" stroke="#6c584c" stroke-width="5"/>`).join('')}
    <!-- Steam Locomotive Train -->
    <g transform="translate(180, 175)">
      <!-- Steam Clouds -->
      <circle cx="190" cy="-20" r="22" fill="#ffffff" opacity="0.85"/>
      <circle cx="230" cy="-45" r="30" fill="#ffffff" opacity="0.75"/>
      <circle cx="280" cy="-70" r="38" fill="#ffffff" opacity="0.6"/>
      <!-- Cab (Rear) -->
      <rect x="0" y="20" width="90" height="110" rx="4" fill="#d90429"/>
      <rect x="15" y="35" width="45" height="40" rx="4" fill="#e0fbfc"/>
      <!-- Boiler (Front) -->
      <rect x="90" y="45" width="120" height="85" fill="#1d3557"/>
      <polygon points="210,45 235,80 235,130 210,130" fill="#e63946"/>
      <!-- Chimney / Smokestack -->
      <polygon points="170,45 190,45 195,5 165,5" fill="#343a40"/>
      <!-- Headlight -->
      <circle cx="238" cy="90" r="10" fill="#ffe66d"/>
      <!-- Wheels -->
      <circle cx="35" cy="135" r="24" fill="#212529" stroke="#adb5bd" stroke-width="6"/>
      <circle cx="95" cy="135" r="24" fill="#212529" stroke="#adb5bd" stroke-width="6"/>
      <circle cx="155" cy="135" r="24" fill="#212529" stroke="#adb5bd" stroke-width="6"/>
      <circle cx="205" cy="143" r="16" fill="#212529" stroke="#adb5bd" stroke-width="5"/>
      <line x1="35" y1="135" x2="155" y2="135" stroke="#f8f9fa" stroke-width="6"/>
    </g>
  </svg>`,

  // Level 8: Jungle
  'level_8.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <!-- Deep jungle foliage backdrop -->
    <rect width="650" height="390" fill="#1b4332"/>
    <!-- Layered Canopy -->
    <ellipse cx="80" cy="60" rx="140" ry="100" fill="#2d6a4f"/>
    <ellipse cx="320" cy="40" rx="180" ry="90" fill="#40916c"/>
    <ellipse cx="560" cy="70" rx="150" ry="100" fill="#2d6a4f"/>
    <!-- Waterfall in background -->
    <path d="M 270 90 L 350 90 L 370 390 L 250 390 Z" fill="#52b788"/>
    <path d="M 285 90 L 335 90 L 350 390 L 270 390 Z" fill="#90e0ef"/>
    <path d="M 298 90 L 322 90 L 330 390 L 290 390 Z" fill="#ffffff" opacity="0.8"/>
    <!-- Giant Tropical Monstera Leaves & Vines -->
    <path d="M -20 220 C 120 180 180 320 220 390" stroke="#74c69d" stroke-width="16" fill="none"/>
    <ellipse cx="140" cy="270" rx="70" ry="40" fill="#52b788" transform="rotate(-30 140 270)"/>
    <!-- Toucan Sitting on branch (Right) -->
    <g transform="translate(460, 210)">
      <!-- Branch -->
      <rect x="-80" y="45" width="220" height="18" rx="8" fill="#5c4033"/>
      <!-- Body -->
      <ellipse cx="0" cy="0" rx="36" ry="48" fill="#111111"/>
      <ellipse cx="-12" cy="0" rx="20" ry="28" fill="#ffb703"/>
      <!-- Eye -->
      <circle cx="-16" cy="-24" r="7" fill="#00b4d8"/>
      <circle cx="-16" cy="-24" r="3" fill="#111111"/>
      <!-- Giant Colorful Bill / Beak -->
      <path d="M -26 -32 C -80 -35 -110 -15 -105 10 C -70 12 -40 5 -26 -5 Z" fill="#ff7b00"/>
      <path d="M -105 10 C -95 -5 -80 -15 -60 -18 L -65 8 Z" fill="#d90429"/>
      <!-- Tail -->
      <polygon points="20,25 45,95 10,85" fill="#111111"/>
      <polygon points="20,25 35,45 10,35" fill="#d90429"/>
    </g>
  </svg>`,

  // Level 9: Castle
  'level_9.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <!-- Sunset Sky -->
    <defs>
      <linearGradient id="sky9" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#ff758f"/>
        <stop offset="60%" stop-color="#ffb3c1"/>
        <stop offset="100%" stop-color="#ffe5d9"/>
      </linearGradient>
    </defs>
    <rect width="650" height="390" fill="url(#sky9)"/>
    <!-- Green Hill -->
    <ellipse cx="325" cy="420" rx="420" ry="190" fill="#40916c"/>
    <!-- Moat Water -->
    <path d="M 0 350 Q 325 320 650 350 L 650 390 L 0 390 Z" fill="#48cae4"/>
    <!-- Stone Castle -->
    <g transform="translate(195, 110)">
      <!-- Main Wall -->
      <rect x="50" y="80" width="160" height="110" fill="#8d99ae"/>
      <!-- Crenellations (Battlements) -->
      ${Array.from({length: 6}).map((_, i) => `<rect x="${60 + i*25}" y="65" width="16" height="18" fill="#8d99ae"/>`).join('')}
      <!-- Left Tower -->
      <rect x="0" y="40" width="65" height="150" fill="#6c757d"/>
      <polygon points="-5,40 32,-15 70,40" fill="#d90429"/>
      <rect x="30" y="-35" width="5" height="20" fill="#333333"/>
      <polygon points="35,-35 55,-25 35,-15" fill="#ffd166"/>
      <!-- Right Tower -->
      <rect x="195" y="40" width="65" height="150" fill="#6c757d"/>
      <polygon points="190,40 227,-15 265,40" fill="#d90429"/>
      <rect x="225" y="-35" width="5" height="20" fill="#333333"/>
      <polygon points="230,-35 250,-25 230,-15" fill="#ffd166"/>
      <!-- Central Keep Tower -->
      <rect x="95" y="20" width="70" height="70" fill="#495057"/>
      <polygon points="90,20 130,-30 170,20" fill="#118ab2"/>
      <!-- Arch Gate / Drawbridge -->
      <path d="M 105 190 L 105 135 Q 130 115 155 135 L 155 190 Z" fill="#343a40"/>
      <!-- Windows -->
      <rect x="20" y="80" width="12" height="22" rx="6" fill="#ffeaa7"/>
      <rect x="228" y="80" width="12" height="22" rx="6" fill="#ffeaa7"/>
    </g>
  </svg>`,

  // Level 10: Rainbow landscape
  'level_10.svg': `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 650 390" width="650" height="390">
    <defs>
      <linearGradient id="sky10" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#bde0fe"/>
        <stop offset="100%" stop-color="#e8f4f8"/>
      </linearGradient>
    </defs>
    <rect width="650" height="390" fill="url(#sky10)"/>
    <!-- Rainbow Arcs -->
    <g transform="translate(325, 300)">
      <circle cx="0" cy="0" r="270" fill="none" stroke="#e63946" stroke-width="14"/>
      <circle cx="0" cy="0" r="256" fill="none" stroke="#f4a261" stroke-width="14"/>
      <circle cx="0" cy="0" r="242" fill="none" stroke="#ffb703" stroke-width="14"/>
      <circle cx="0" cy="0" r="228" fill="none" stroke="#52b788" stroke-width="14"/>
      <circle cx="0" cy="0" r="214" fill="none" stroke="#00b4d8" stroke-width="14"/>
      <circle cx="0" cy="0" r="200" fill="none" stroke="#0077b6" stroke-width="14"/>
      <circle cx="0" cy="0" r="186" fill="none" stroke="#7209b7" stroke-width="14"/>
    </g>
    <!-- Rolling Green Hills Foreground -->
    <ellipse cx="100" cy="380" rx="260" ry="120" fill="#70e000"/>
    <ellipse cx="550" cy="380" rx="280" ry="130" fill="#38b000"/>
    <ellipse cx="325" cy="400" rx="300" ry="110" fill="#007200"/>
    <!-- Clouds over Rainbow ends -->
    <g transform="translate(90, 270)">
      <circle cx="-25" cy="0" r="30" fill="#ffffff"/>
      <circle cx="10" cy="-15" r="38" fill="#ffffff"/>
      <circle cx="45" cy="5" r="28" fill="#ffffff"/>
    </g>
    <g transform="translate(560, 270)">
      <circle cx="-35" cy="5" r="28" fill="#ffffff"/>
      <circle cx="0" cy="-15" r="38" fill="#ffffff"/>
      <circle cx="35" cy="0" r="30" fill="#ffffff"/>
    </g>
  </svg>`
};

for (const [filename, content] of Object.entries(svgs)) {
  fs.writeFileSync(path.join(outDir, filename), content.trim());
  console.log('Created ' + filename);
}
console.log('All level artwork generated successfully.');

---
name: brutalist-ui-skill
approval_source: agent
description: "Raw mechanical interfaces fusing Swiss typographic print with military terminal aesthetics. Rigid grids, extreme type scale contrast, utilitarian color, analog degradation effects. From Leonxlnx/taste-skill."
version: 1.0.0
source: https://github.com/Leonxlnx/taste-skill/tree/main/skills/brutalist-skill
license: MIT
author: Leonxlnx
read_scope: profile
---

# SKILL: Industrial Brutalism & Tactical Telemetry UI

## 1. Visual Archetypes — Pick ONE per project
### 2.1 Swiss Industrial Print (Light)
High-contrast light mode, monolithic heavy sans-serif, unforgiving structural grids, oversized numerals/letterforms, primary red accent.

### 2.2 Tactical Telemetry & CRT Terminal (Dark)
Dark mode exclusive, high-density tabular data, monospaced typography dominance, ASCII framing devices, simulated hardware limitations (phosphor glow, scanlines).

## 2. Typographic Architecture
### Macro-Typography (Structural Headers)
- **Fonts:** Neue Haas Grotesk Black, Inter Extra Bold/Black, Archivo Black, Monument Extended
- **Scale:** `clamp(4rem, 10vw, 15rem)`
- **Tracking:** Tight, negative (`-0.03em` to `-0.06em`)
- **Leading:** Compressed (`0.85` to `0.95`)
- **Casing:** Exclusively uppercase

### Micro-Typography (Data & Telemetry)
- **Fonts:** JetBrains Mono, IBM Plex Mono, Space Mono, VT323
- **Scale:** Fixed small (`0.7rem` to `0.875rem`)
- **Tracking:** Generous (`0.05em` to `0.1em`)
- **Casing:** Exclusively uppercase

## 3. Color System
### Swiss Industrial Print (Light):
- Background: `#F4F4F0` (matte unbleached paper)
- Foreground: `#050505` to `#111111` (carbon ink)
- Accent: `#E61919` or `#FF2A2A` (aviation red — ONLY accent)

### Tactical Telemetry (Dark):
- Background: `#0A0A0A` or `#121212` (deactivated CRT)
- Foreground: `#EAEAEA` (white phosphor)
- Accent: `#E61919` or `#FF2A2A` (aviation red)
- Terminal Green (`#4AF626`): Optional for ONE specific element only

## 4. Layout
- **Blueprint Grid:** Strict CSS Grid. Elements anchored precisely to grid tracks.
- **Visible Compartmentalization:** Solid borders (`1px` or `2px solid`) delineating zones.
- **Bimodal Density:** Extreme data density + vast calculated negative space.
- **Geometry:** Absolute rejection of `border-radius`. All corners 90 degrees.

## 5. UI Components
- **Syntax Decoration:** ASCII framing: `[ DELIVERY SYSTEMS ]`, `< RE-IND >`, `>>>`, `///`
- **Industrial Markers:** Registration marks `®`, copyright `©`, crosshairs `+`
- **Technical Assets:** Barcodes, warning stripes, randomized string data (`REV 2.6`)

## 6. Post-Processing Effects
- **CRT Scanlines:** `repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(0,0,0,0.1) 2px, rgba(0,0,0,0.1) 4px)`
- **Halftone Dithering:** `mix-blend-mode: multiply` + SVG radial dot patterns
- **Mechanical Noise:** Global low-opacity SVG static filter on DOM root

## 7. Engineering Directives
1. **Grid Determinism:** `display: grid; gap: 1px;` with contrasting parent/child backgrounds for razor-thin lines
2. **Semantic Rigidity:** `<data>`, `<samp>`, `<kbd>`, `<output>`, `<dl>`
3. **Typography Clamping:** CSS `clamp()` for macro-typography only

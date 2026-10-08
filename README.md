# SmoothThai

[![Minecraft 1.20.1 / 1.21.1](https://img.shields.io/badge/Minecraft-1.20.1%20%7C%201.21.1-62B47A?style=flat-square)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](#)

SmoothThai — ฟอนต์ไทยนุ่มตา อ่านง่ายขึ้นด้วย Caxton (bundled) พร้อมฟอนต์ Noto Sans Thai ในตัว ลงมอดเดียวจบ ไม่ต้องลง Resource Pack เพิ่ม

A smoother, more readable Thai text experience for Minecraft. Bundles [Caxton](https://modrinth.com/mod/caxton) (SDF-based TrueType/OpenType rendering) and Noto Sans Thai — no separate resource pack required.

## Supported

| Minecraft | Fabric | Forge | NeoForge |
|-----------|--------|-------|----------|
| 1.20.1    | ✅     | ✅    | —        |
| 1.21.1    | ✅     | —     | ✅       |

## Installation

1. Install your mod loader of choice (Fabric / Forge / NeoForge) for a supported version.
2. Drop the matching jar from `1.20.1/.../build/libs/` or `1.21.1/.../build/libs/` into your `mods` folder.
3. Launch — Caxton loads automatically (embedded Jar-in-Jar).

## Build

Requires JDK 17+ (and JDK 21 for the 1.21.1 build). Gradle will provision toolchains automatically.

```bash
cd 1.20.1 && ../gradlew build    # Fabric + Forge artifacts
cd ../1.21.1 && ../gradlew build # Fabric + NeoForge artifacts
```

Outputs:
- `1.20.1/fabric/build/libs/SmoothThai-1.20.1-fabric-0.1.0.jar`
- `1.20.1/forge/build/libs/SmoothThai-1.20.1-forge-0.1.0.jar`
- `1.21.1/fabric/build/libs/SmoothThai-1.21.1-fabric-0.1.0.jar`
- `1.21.1/neoforge/build/libs/SmoothThai-1.21.1-neoforge-0.1.0.jar`

## Project layout

```
modsmooththai/
├── 1.20.1/          # Multiloader (common / fabric / forge)
├── 1.21.1/          # Multiloader (common / fabric / neoforge)
├── build-logic/     # Shared gradle conventions
└── repo/ (per-version)  # Local maven of the bundled Caxton jars
```

## License & Credits

Developed by **Aven Labs**. MIT License. Font: Noto Sans Thai (OFL). Bundled mod: Caxton by flirora/Kyarei (MIT).

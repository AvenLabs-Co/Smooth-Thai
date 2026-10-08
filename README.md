<div align="center">
  <h1>🇹🇭 SmoothThai</h1>
  <p><i>A smoother and more readable Thai text experience for Minecraft.</i></p>

  [![Minecraft](https://img.shields.io/badge/Minecraft-1.20.1%20%7C%201.21.1-62B47A?style=for-the-badge&logo=minecraft)](https://www.minecraft.net)
  [![Loaders](https://img.shields.io/badge/Fabric%20%7C%20Forge%20%7C%20NeoForge-F16436?style=for-the-badge)](#)
  [![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](#)
  [![Downloads](https://img.shields.io/github/downloads/AvenLabs-Co/Smooth-Thai/total?style=for-the-badge)](https://github.com/AvenLabs-Co/Smooth-Thai/releases)
</div>

---

## Thai | ไทย

ฟอนต์ไทยนุ่มตา อ่านง่ายขึ้นด้วย **Caxton** (bundled) พร้อมฟอนต์ **Noto Sans Thai** ในตัว ลงมอดเดียวจบ ไม่ต้องลง Resource Pack เพิ่ม
/
Smoother, more readable Thai text for Minecraft — Caxton (SDF font rendering) and Noto Sans Thai bundled in one jar. No separate resource pack required.

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🇹🇭 **Smooth Thai font** | Noto Sans Thai renders tone marks, vowels, and stacked glyphs cleanly |
| 🔍 **Crisp rendering** | Caxton's SDF rasterizer keeps text sharp at every GUI scale |
| 📦 **All-in-one** | Caxton embedded via Jar-in-Jar — install one jar only |
| 🔀 **Any loader** | Fabric · Forge · NeoForge across two Minecraft versions |

## 🎮 Supported

| Minecraft | Fabric | Forge | NeoForge |
|-----------|--------|-------|----------|
| 1.20.1    | ✅     | ✅    | —        |
| 1.21.1    | ✅     | —     | ✅       |

## ⬇️ Installation

1. Install the mod loader of your choice for a supported version.
2. Grab the matching jar from the [latest release](https://github.com/AvenLabs-Co/Smooth-Thai/releases).
3. Drop it into your `mods` folder and launch — done.

```text
mods/
└── SmoothThai-<mc version>-<loader>-0.1.0.jar
```

## 🛠️ Development

Requires a JDK (17 for 1.20.1, 21 for 1.21.1 — toolchains auto-provision via Gradle).

```bash
cd 1.20.1 && ../gradlew build   # Fabric + Forge
cd ../1.21.1 && ../gradlew build # Fabric + NeoForge
```

| Version | Loader | Output |
|---------|--------|--------|
| 1.20.1 | Fabric | `SmoothThai-1.20.1-fabric-0.1.0.jar` |
| 1.20.1 | Forge  | `SmoothThai-1.20.1-forge-0.1.0.jar` |
| 1.21.1 | Fabric | `SmoothThai-1.21.1-fabric-0.1.0.jar` |
| 1.21.1 | NeoForge | `SmoothThai-1.21.1-neoforge-0.1.0.jar` |

<details>
<summary><b>📂 Project layout</b></summary>

```
modsmooththai/
├── 1.20.1/          # Multiloader (common / fabric / forge)
├── 1.21.1/          # Multiloader (common / fabric / neoforge)
├── build-logic/     # Shared gradle conventions
└── repo/ (per-version)  # Local maven of the bundled Caxton jars
```
</details>

---

<div align="center">
  <sub><b>Developed by <a href="https://github.com/AvenLabs-Co">Aven Labs</a></b></sub><br/>
  <sub>Font: Noto Sans Thai (OFL) · Bundled mod: Caxton by flirora/Kyarei (MIT)</sub>
</div>

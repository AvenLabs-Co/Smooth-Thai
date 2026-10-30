<div align="center">
  <h1>🇹🇭 SmoothThai</h1>
  <p><i>A smoother and more readable Thai text experience for Minecraft.</i></p>

  [![Minecraft](https://img.shields.io/badge/Minecraft-1.20.1%20%7C%201.21.1%20%7C%2026.3-62B47A?style=for-the-badge&logo=minecraft)](https://www.minecraft.net)
  [![Loaders](https://img.shields.io/badge/Fabric%20%7C%20Forge%20%7C%20NeoForge-F16436?style=for-the-badge)](#)
  [![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)
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
| 🔀 **Any loader** | Fabric · Forge · NeoForge across supported Minecraft versions |

## 🎮 Supported

<!-- supported:start -->
| Minecraft | Fabric | Forge | NeoForge |
|-----------|--------|-------|----------|
| 1.20.1 | ✅ | ✅ | — |
| 1.21.1 | ✅ | — | ✅ |
| 26.3 | ✅ | — | ✅ |
<!-- supported:end -->

## ⬇️ Installation

1. Install the mod loader of your choice for a supported version.
2. Grab the matching jar from the [latest release](https://github.com/AvenLabs-Co/Smooth-Thai/releases).
3. Drop it into your `mods` folder and launch — done.

> ⚠️ **Client-side only** — install on the client. Do not put it on a dedicated server (the bundled Caxton font engine is client-only).

```text
mods/
└── SmoothThai-<mc version>-<loader>-<version>.jar
```

## 🛠️ Development

Each Minecraft version is a self-contained Gradle build under `versions/`. This keeps the
toolchains for old and new Minecraft releases independent.

```bash
# Build every version (set JDK21_HOME / JDK25_HOME if needed)
scripts/build-all.sh

# Or build one version
cd versions/1.21.1 && ./gradlew build
```

| Minecraft | Java | Gradle | Loaders |
|-----------|------|--------|---------|
| 1.20.1 | 17 | 8.8 | Fabric, Forge |
| 1.21.1 | 21 | 8.8 | Fabric, NeoForge |
| 26.3 | 25 | 9.8.2 | Fabric, NeoForge |

See [`docs/development.md`](docs/development.md) for the layout and test commands,
and [`docs/adding-a-version.md`](docs/adding-a-version.md) when adding another Minecraft release.

## 📦 Build Outputs

<!-- artifacts:start -->
| Minecraft | Loader | Output |
|-----------|--------|--------|
| 1.20.1 | Fabric | `SmoothThai-1.20.1-fabric-0.1.1.jar` |
| 1.20.1 | Forge | `SmoothThai-1.20.1-forge-0.1.1.jar` |
| 1.21.1 | Fabric | `SmoothThai-1.21.1-fabric-0.1.1.jar` |
| 1.21.1 | NeoForge | `SmoothThai-1.21.1-neoforge-0.1.1.jar` |
| 26.3 | Fabric | `SmoothThai-26.3-fabric-0.1.2.jar` |
| 26.3 | NeoForge | `SmoothThai-26.3-neoforge-0.1.2.jar` |
<!-- artifacts:end -->

## 📂 Project layout

```text
Smooth-Thai/
├── build-logic/        # Shared Gradle conventions
├── docs/               # Development, release, and platform notes
├── scripts/            # Build, verify, and documentation helpers
├── shared/             # Sources and resources used by every version
└── versions/
    ├── 1.20.1/         # Fabric + Forge
    ├── 1.21.1/         # Fabric + NeoForge
    └── 26.3/           # Fabric + NeoForge
```

## ⚠️ Known issues

* **Shader packs (Iris, etc.):** Caxton's SDF text rendering uses custom core shaders, which shader loaders replace — sign text and other in-world text may become invisible while shaders are enabled. Workaround: disable shaders / remove Iris when using SmoothThai. (Upstream Caxton limitation, cannot be fixed in this mod.)

---

<div align="center">
  <sub><b>Developed by <a href="https://github.com/AvenLabs-Co">Aven Labs</a></b></sub><br/>
  <sub>Font: Noto Sans Thai (OFL) · Bundled mod: Caxton by flirora/Kyarei (MIT)</sub>
</div>

<div align="center">
  <h1>🇹🇭 SmoothThai</h1>
  <p><i>A smoother and more readable Thai text experience for Minecraft.</i></p>
</div>

---

If you have ever struggled to read Thai text in Minecraft because the characters look jagged, thin, or hard on the eyes, SmoothThai provides a complete typography overhaul. 

Designed with readability and accessibility in mind, this mod swaps in the clean, professionally hinted **Noto Sans Thai** typeface and renders it with **Caxton**'s advanced TrueType/OpenType font engine — so every glyph is anti-aliased, well-spaced, and crisp at any GUI scale. And because **Caxton is bundled inside the mod**, you only need to install one file. No extra resource packs required.

## ✨ Key Features

* **Vanilla-Friendly Typography:** Every Thai character and English glyph is perfectly proportioned and baseline-aligned, so in-game text feels native rather than patched in.
* **Crisp at Any GUI Scale:** From low-resolution windows to 4K monitors, the SDF-based rasterizer from Caxton keeps text sharp without blurry, pixelated edges.
* **Full Thai Unicode Support:** Tone marks, upper and lower vowels, and complex stacked glyphs all render correctly — ideal for reading books, signs, chat, and the UI.
* **One-Jar Convenience:** Caxton is bundled via Jar-in-Jar, so the mod works out of the box on Fabric, Forge, and NeoForge.

## 🛠️ Technical Details

<details>
<summary><b>Why is this needed?</b></summary>

Minecraft's default font renderer is built for a legacy texture-atlas approach and struggles with complex scripts. Thai relies on upper and lower vowel markers and tonal marks, which often overlap or look cluttered in vanilla. SmoothThai replaces the default `minecraft:default` font provider with Caxton's SDF text rendering, which measures and rasterizes true glyph outlines for accurate, smooth results.
</details>

<details>
<summary><b>Installation</b></summary>

Download the jar matching your Minecraft version and mod loader (Fabric / Forge / NeoForge), then drop it into your `mods` folder. Caxton is included — no separate downloads, no extra resource packs.

> ⚠️ **Client-side only** — install on the client. Do not put it on a dedicated server (the bundled Caxton font engine is client-only and will crash a server).
</details>

<details>
<summary><b>Known issues</b></summary>

* **Shader packs (Iris, etc.):** Caxton's SDF text rendering relies on custom core shaders, which shader loaders replace — sign text and other in-world text may become invisible while shaders are enabled. Workaround: disable shaders when using SmoothThai. (Upstream Caxton limitation.)
</details>

<details>
<summary><b>Supported Versions</b></summary>

* Minecraft 1.20.1 — Fabric, Forge
* Minecraft 1.21.1 — Fabric, NeoForge
</details>

---

*By fixing the foundational flaws in how the game renders complex scripts, SmoothThai makes the Thai language feel natively supported, beautifully integrated, and effortless to read.* 

*Developed by Aven Labs*

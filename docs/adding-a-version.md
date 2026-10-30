# Adding a Minecraft version

Use this checklist when a new Minecraft release needs support.

1. Pick the closest existing version directory (usually the newest one) and copy it:

   ```bash
   cp -a versions/1.21.1 versions/26.3
   rm -rf versions/26.3/build versions/26.3/*/build versions/26.3/.gradle versions/26.3/*/.gradle versions/26.3/runs versions/26.3/*/runs
   ```

2. Update `versions/<new>/gradle.properties`:

   - `version` — the mod version for this release;
   - `java_version` — the Java level required by Minecraft;
   - `minecraft_version` and `minecraft_version_range`;
   - `fabric_version` and `fabric_loader_version`;
   - `neoforge_version` and `neoforge_loader_version_range` (or Forge values);
   - `neo_form_version` when using NeoForge;
   - `caxton_version` — the Caxton build for this Minecraft version;
   - `pack_format` — the resource pack format.

3. Update the plugin versions in `versions/<new>/build.gradle`:

   - Fabric Loom;
   - ModDevGradle or ForgeGradle.

4. Update shared compile-only dependencies in `common/build.gradle` if the
   loader's Mixin/MixinExtras versions changed.

5. Give the version its own Gradle wrapper. The wrapper must match the Gradle
   version required by the toolchain:

   ```bash
   cd versions/26.3
   gradle wrapper --gradle-version 9.8.2
   ```

   Do not reuse a wrapper that is too old for Loom or ModDevGradle.

6. Update the loader metadata if needed:

   - `fabric/src/main/resources/fabric.mod.json`;
   - `neoforge/src/main/resources/META-INF/neoforge.mods.toml`;
   - `forge/src/main/resources/META-INF/mods.toml`.

7. Build and verify:

   ```bash
   cd versions/26.3
   ./gradlew --no-daemon clean build
   cd ../..
   scripts/verify-artifacts.sh 26.3
   ```

8. Regenerate the README tables:

   ```bash
   scripts/render-tables.py
   ```

9. Add a `CHANGELOG.md` entry and update `docs/modrinth.md`.

10. Commit the new version as its own change. Do not mix it with unrelated
    fixes.

# Releasing

1. Decide which versions the release covers.
2. Bump `version` in `versions/<mc>/gradle.properties` for each affected version.
3. Update `CHANGELOG.md`.
4. Build and verify everything:

   ```bash
   export JDK21_HOME=/path/to/jdk-21
   export JDK25_HOME=/path/to/jdk-25
   scripts/build-all.sh
   scripts/verify-artifacts.sh
   scripts/render-tables.py --check
   ```

5. Commit the release and tag it. Tags follow `v<mod version>+<minecraft version>`:

   ```bash
   git tag v0.1.2+26.3
   git push origin main
   git push origin v0.1.2+26.3
   ```

6. Upload the jars from `versions/<mc>/<loader>/build/libs/` to the release.
   Fabric and NeoForge jars include Caxton; no separate download is needed.

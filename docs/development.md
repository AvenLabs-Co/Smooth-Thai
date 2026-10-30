# Development

## Prerequisites

- A JDK for the Minecraft version you are building (17, 21, or 25).
- Network access on the first build so Gradle can fetch Minecraft, loaders, and Caxton.
- A POSIX shell for `scripts/*.sh`; the Gradle wrappers also work on Windows.

Gradle itself must run on a JDK new enough for the selected toolchain:

| Minecraft | Gradle | Runtime JDK | Toolchain |
|-----------|--------|-------------|-----------|
| 1.20.1 | 8.8 | 21 | 17 |
| 1.21.1 | 8.8 | 21 | 21 |
| 26.3 | 9.8.2 | 25 | 25 |

## Layout

```text
build-logic/          Shared Gradle conventions (multiloader-common, multiloader-loader)
docs/                 Development and release documentation
scripts/              build-all.sh, verify-artifacts.sh, render-tables.py
shared/java/          Java sources shared by every Minecraft version
shared/resources/     Fonts, icon, font definitions, and pack.mcmeta template
versions/<mc>/        One self-contained Gradle build per Minecraft version
```

Every `versions/<mc>/` directory is an independent build with its own wrapper:

```text
versions/<mc>/
├── gradle.properties   # Single source of truth for this version's pins
├── settings.gradle
├── build.gradle
├── gradlew, gradlew.bat
├── gradle/wrapper/
├── common/
└── <loader>/           # fabric, forge, and/or neoforge
```

A single Gradle build cannot host every Minecraft release: the Loom, ForgeGradle,
and ModDevGradle plugin versions conflict, and 26.3 requires a newer Gradle/JDK.
Keeping one build per release is deliberate.

## Building

Build every version:

```bash
export JDK21_HOME=/path/to/jdk-21
export JDK25_HOME=/path/to/jdk-25
scripts/build-all.sh
```

Build one version:

```bash
cd versions/1.21.1
./gradlew --no-daemon clean build
```

`gradlew` reuses `gradle.properties`, so the Java toolchain is selected
automatically. Set `JAVA_HOME` to a runtime JDK new enough for that version.

## Verifying artifacts

```bash
scripts/verify-artifacts.sh          # all versions
scripts/verify-artifacts.sh 26.3     # one version
```

The script checks:

- the expected jar exists for every loader;
- Caxton is embedded in the jar;
- the compiled `Constants.class` targets the expected Java version;
- the project builds with the expected layout.

## Shared sources and resources

`shared/java` and `shared/resources` are added to every version's `common`
source set. Version-specific code belongs in `versions/<mc>/<loader>/src`.

`shared/resources/pack.mcmeta` is a template. Each version sets `pack_format`
in its `gradle.properties`, and the normal `processResources` expansion fills it in.

## Dependencies

Caxton is resolved from Modrinth's Maven repository:

```groovy
maven { url = uri("https://api.modrinth.com/maven") }
```

The artifact is `maven.modrinth:k8iIgzXE:<caxton_version>-<LOADER>`. The
`caxton_version` value lives in each version's `gradle.properties`, for example
`1.2.0-alpha.3+26.3`.

Fabric and NeoForge bundle Caxton through the loaders' normal nested-jar
mechanisms. Forge 1.20.1 resolves the jar from Maven and copies it into
`META-INF/jarjar` during `processResources`; no binary is committed.

## README tables

The supported-version and artifact tables in `README.md` are generated:

```bash
scripts/render-tables.py
scripts/render-tables.py --check   # CI mode
```

Do not edit the text between the `<!-- supported:* -->` and `<!-- artifacts:* -->`
markers by hand.

## Continuous integration

`.github/workflows/build.yml` builds every version in a matrix and runs
`scripts/verify-artifacts.sh` for each one. A separate job checks that the
README tables are current.

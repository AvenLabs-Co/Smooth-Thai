#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
versions_dir="$root_dir/versions"

if [[ ! -d "$versions_dir" ]]; then
    echo "No versions directory found at $versions_dir" >&2
    exit 1
fi

# Pick a runtime JDK for each build. Gradle itself must run on a JDK new
# enough for the selected Minecraft toolchain; the project's Java toolchain
# is still selected by gradle.properties.
select_java() {
    local java_version="$1"
    case "$java_version" in
        25) printf '%s' "${JDK25_HOME:-${JAVA_HOME:-}}" ;;
        21|17) printf '%s' "${JDK21_HOME:-${JAVA_HOME:-}}" ;;
        *) printf '%s' "${JAVA_HOME:-}" ;;
    esac
}

status=0
for version_dir in "$versions_dir"/*/; do
    [[ -f "$version_dir/gradlew" ]] || continue
    version="$(basename "$version_dir")"
    java_version="$(sed -n 's/^java_version=//p' "$version_dir/gradle.properties" | head -n1)"
    java_home="$(select_java "$java_version")"

    echo "==> Building Minecraft $version (Java $java_version)"
    if [[ -n "$java_home" ]]; then
        (cd "$version_dir" && JAVA_HOME="$java_home" PATH="$java_home/bin:$PATH" ./gradlew --no-daemon clean build) || status=$?
    else
        (cd "$version_dir" && ./gradlew --no-daemon clean build) || status=$?
    fi
done

exit "$status"

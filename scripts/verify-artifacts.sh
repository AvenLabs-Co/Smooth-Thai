#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
versions_dir="$root_dir/versions"
filter="${1:-}"

failures=0

prop() {
    local file="$1" key="$2"
    sed -n "s/^${key}=//p" "$file" | head -n1
}

pass() {
    printf '  [ok]   %s\n' "$1"
}

fail() {
    printf '  [FAIL] %s\n' "$1"
    failures=$((failures + 1))
}

for version_dir in "$versions_dir"/*/; do
    [[ -f "$version_dir/gradle.properties" ]] || continue
    mc_version="$(basename "$version_dir")"
    if [[ -n "$filter" && "$filter" != "$mc_version" ]]; then
        continue
    fi

    props="$version_dir/gradle.properties"
    mod_name="$(prop "$props" mod_name)"
    mod_version="$(prop "$props" version)"
    java_version="$(prop "$props" java_version)"
    case "$java_version" in
        17) expected_major=61 ;;
        21) expected_major=65 ;;
        25) expected_major=69 ;;
        *) expected_major="" ;;
    esac

    echo "==> Minecraft $mc_version ($mod_name $mod_version)"

    for loader in fabric forge neoforge; do
        [[ -d "$version_dir/$loader" ]] || continue
        jar="$version_dir/$loader/build/libs/${mod_name}-${mc_version}-${loader}-${mod_version}.jar"

        if [[ ! -f "$jar" ]]; then
            fail "missing $loader jar: $jar"
            continue
        fi
        pass "$loader jar exists"

        case "$loader" in
            fabric)
                if unzip -Z1 "$jar" | grep -Eq '^META-INF/jars/.*(caxton|k8iIgzXE).*\.jar$'; then
                    pass "$loader bundles Caxton"
                else
                    fail "$loader does not bundle Caxton"
                fi
                ;;
            *)
                if unzip -Z1 "$jar" | grep -Eq '^META-INF/jarjar/.*(caxton|k8iIgzXE).*\.jar$'; then
                    pass "$loader bundles Caxton"
                else
                    fail "$loader does not bundle Caxton"
                fi
                ;;
        esac

        if [[ -n "$expected_major" ]]; then
            actual_major="$(unzip -p "$jar" com/smooththai/Constants.class | od -An -t u1 -j 6 -N 2 | awk '{print $1 * 256 + $2}')"
            if [[ "$actual_major" == "$expected_major" ]]; then
                pass "$loader class file targets Java $java_version"
            else
                fail "$loader class file major version $actual_major, expected $expected_major"
            fi
        fi

        mc_range="$(prop "$props" minecraft_version_range)"
        case "$loader" in
            fabric)
                metadata="$(unzip -p "$jar" fabric.mod.json)"
                if grep -Eq "\"version\"[[:space:]]*:[[:space:]]*\"$mod_version\"" <<<"$metadata" \
                    && grep -Eq "\"minecraft\"[[:space:]]*:[[:space:]]*\"~$mc_version\"" <<<"$metadata"; then
                    pass "$loader metadata version and Minecraft range"
                else
                    fail "$loader metadata version or Minecraft range is wrong"
                fi
                ;;
            forge)
                metadata="$(unzip -p "$jar" META-INF/mods.toml)"
                if grep -Fq "version = \"$mod_version\"" <<<"$metadata" \
                    && grep -Fq "versionRange = \"$mc_range\"" <<<"$metadata"; then
                    pass "$loader metadata version and Minecraft range"
                else
                    fail "$loader metadata version or Minecraft range is wrong"
                fi
                ;;
            neoforge)
                metadata="$(unzip -p "$jar" META-INF/neoforge.mods.toml)"
                if grep -Fq "version = \"$mod_version\"" <<<"$metadata" \
                    && grep -Fq "versionRange = \"$mc_range\"" <<<"$metadata"; then
                    pass "$loader metadata version and Minecraft range"
                else
                    fail "$loader metadata version or Minecraft range is wrong"
                fi
                ;;
        esac
    done
done

if [[ "$failures" -ne 0 ]]; then
    echo "Artifact verification failed with $failures problem(s)." >&2
    exit 1
fi

echo "Artifact verification passed."

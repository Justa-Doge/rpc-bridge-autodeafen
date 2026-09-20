#!/bin/sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"

package_name="AutoDeafen-Bridge"
dist_dir="$repo_root/dist"
package_dir="$dist_dir/$package_name"
archive_path="$dist_dir/$package_name.zip"

if [ ! -f "$repo_root/build/bridge.exe" ]; then
    printf '%s\n' 'build/bridge.exe is missing. Build the bridge before packaging.' >&2
    exit 1
fi

if [ -e "$package_dir" ]; then
    rm -rf -- "$package_dir"
fi
rm -f -- "$archive_path" "$dist_dir/SHA256SUMS"
mkdir -p "$package_dir"

install -m 755 "$repo_root/build/bridge.exe" "$package_dir/bridge.exe"
install -m 755 "$repo_root/build/bridge.sh" "$package_dir/bridge.sh"
install -m 755 "$repo_root/build/launchd.sh" "$package_dir/launchd.sh"
install -m 644 "$repo_root/SETUP.txt" "$package_dir/SETUP.txt"
install -m 644 "$repo_root/README.md" "$package_dir/README.md"
install -m 644 "$repo_root/LICENSE" "$package_dir/LICENSE"

(
    cd "$dist_dir"
    zip -q -r "$package_name.zip" "$package_name"
)

if command -v sha256sum >/dev/null 2>&1; then
    (
        cd "$dist_dir"
        sha256sum "$package_name.zip" > SHA256SUMS
    )
else
    checksum=$(shasum -a 256 "$archive_path" | awk '{ print $1 }')
    printf '%s  %s\n' "$checksum" "$package_name.zip" > "$dist_dir/SHA256SUMS"
fi

printf 'Created %s\n' "$package_dir"
printf 'Created %s\n' "$archive_path"
printf 'Created %s\n' "$dist_dir/SHA256SUMS"

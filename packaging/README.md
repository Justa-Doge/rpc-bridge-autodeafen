# Release packaging

Run `./packaging/build-package.sh` after building `build/bridge.exe`.
The script creates the following final release files under `dist/`:

- `AutoDeafen-Bridge/` — unpacked package folder;
- `AutoDeafen-Bridge.zip` — user download;
- `SHA256SUMS` — checksum for the ZIP.

The package contains `bridge.exe`, `bridge.sh`, `launchd.sh`, the AutoDeafen
`SETUP.txt`, the project README, and the MIT license. The GitHub Actions build
uses this same script so local packages and tagged release assets have the same
layout.

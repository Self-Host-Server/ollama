#!/bin/sh
# Downloads the latest git-cliff release and prints the path to its binary on
# stdout. Shared by pr-description.yml and release.yml so the download logic
# lives in exactly one place.
set -e

CLIFF_VER=$(curl -sf "https://api.github.com/repos/orhun/git-cliff/releases/latest" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['tag_name'].lstrip('v'))")
curl -fsSL \
  "https://github.com/orhun/git-cliff/releases/download/v${CLIFF_VER}/git-cliff-${CLIFF_VER}-x86_64-unknown-linux-musl.tar.gz" \
  | tar -xz -C /tmp
CLIFF=$(find /tmp -name "git-cliff" -type f | head -1)
chmod +x "$CLIFF"
echo "$CLIFF"

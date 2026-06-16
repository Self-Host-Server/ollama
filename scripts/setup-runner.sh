#!/bin/sh
set -e

# Usage: ./scripts/setup-runner.sh <GITHUB_TOKEN>
# Get token from: https://github.com/gavvahar/ollama/settings/actions/runners/new

REPO_URL="https://github.com/gavvahar/ollama"
TOKEN="${1:?Usage: $0 <GITHUB_TOKEN>}"
RUNNER_DIR="$HOME/actions-runner"

mkdir -p "$RUNNER_DIR"
cd "$RUNNER_DIR"

# Download latest runner
LATEST=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | grep -o '"tag_name": *"[^"]*"' | grep -o 'v[^"]*')
VERSION="${LATEST#v}"
ARCHIVE="actions-runner-linux-x64-${VERSION}.tar.gz"

curl -o "$ARCHIVE" -L "https://github.com/actions/runner/releases/download/${LATEST}/${ARCHIVE}"
tar xzf "$ARCHIVE"
rm "$ARCHIVE"

# Configure
./config.sh --url "$REPO_URL" --token "$TOKEN" --labels "self-hosted,jarvis,linux" --unattended

# Install and start as a service
sudo ./svc.sh install
sudo ./svc.sh start

echo "Runner installed and started."
echo "Check status with: sudo $RUNNER_DIR/svc.sh status"

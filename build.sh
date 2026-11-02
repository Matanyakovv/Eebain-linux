#!/usr/bin/env bash
set -euo pipefail

echo "Building Ebain Linux 0.5"

 apt-get update
 apt-get install -y live-build

mkdir -p ebain-build
cd ebain-build

lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer none

mkdir -p config/package-lists
mkdir -p config/includes.chroot/etc

cat > config/package-lists/ebain.list.chroot <<'EOF'
task-kde-desktop
kde-plasma-desktop
sddm
firefox-esr
konsole
dolphin
kate
ark
plasma-discover
calamares
EOF

cat > config/includes.chroot/etc/os-release <<'EOF'
PRETTY_NAME="Ebain Linux 0.5"
NAME="Ebain Linux"
VERSION_ID="0.5"
VERSION="0.5"
ID=debian
ID_LIKE=debian
VERSION_CODENAME=trixie
HOME_URL="https://www.debian.org/"
EOF

 lb build

echo "Ebain ISO build finished"

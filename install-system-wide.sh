#!/usr/bin/env bash
# Installa MyFirstApp per TUTTI gli utenti del computer (menu Applications condiviso).
set -e

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="/opt/MyFirstApp"

echo "→ Copio MyFirstApp in ${DEST} ..."
sudo mkdir -p "$DEST"
sudo rsync -a --delete \
  --exclude '.git' \
  --exclude 'install-system-wide.sh' \
  --exclude 'MyFirstApp.desktop' \
  "$SRC/" "$DEST/"

echo "→ Permessi: tutti possono leggere e avviare ..."
sudo chmod -R a+rX "$DEST"
sudo chmod +x "$DEST/launch-myfirstapp.sh"

echo "→ Aggiungo al menu Applications di sistema ..."
sudo cp "$DEST/MyFirstApp.desktop.system" /usr/share/applications/MyFirstApp.desktop
sudo chmod 644 /usr/share/applications/MyFirstApp.desktop

if command -v update-desktop-database >/dev/null 2>&1; then
  sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true
fi

echo ""
echo "✓ Fatto! Ogni utente che accede al PC trova MyFirstApp nel menu Applications."
echo "  Percorso: ${DEST}"

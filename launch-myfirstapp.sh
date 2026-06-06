#!/usr/bin/env bash
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_URL="file://${APP_DIR}/lego-costruisci.html"

run_chrome_app() {
  exec "$@" --app="$APP_URL" --name="MyFirstApp" --class="MyFirstApp" %U
}

if flatpak info com.google.Chrome >/dev/null 2>&1; then
  run_chrome_app flatpak run com.google.Chrome
elif command -v google-chrome >/dev/null 2>&1; then
  run_chrome_app google-chrome
elif command -v google-chrome-stable >/dev/null 2>&1; then
  run_chrome_app google-chrome-stable
elif command -v chromium >/dev/null 2>&1; then
  run_chrome_app chromium
elif command -v chromium-browser >/dev/null 2>&1; then
  run_chrome_app chromium-browser
elif command -v brave-browser >/dev/null 2>&1; then
  run_chrome_app brave-browser
elif command -v microsoft-edge >/dev/null 2>&1; then
  run_chrome_app microsoft-edge
else
  notify-send "MyFirstApp" "Serve Google Chrome o Chromium. Firefox non viene usato." 2>/dev/null || \
  zenity --error --text="MyFirstApp ha bisogno di Google Chrome o Chromium.\nFirefox non viene usato." 2>/dev/null || \
  echo "MyFirstApp: installa Google Chrome o Chromium (Firefox non supportato)." >&2
  exit 1
fi

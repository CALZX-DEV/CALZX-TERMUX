#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
CONFIG_DIR="${HOME}/.config/calzx-termux"
BIN_DIR="${PREFIX}/bin"
YOUTUBE_URL="https://youtube.com/@calzxchannel?si=fOW0uEhe90ZQoNAi"
MARKER_START="# >>> CALZX TERMUX START >>>"
MARKER_END="# <<< CALZX TERMUX END <<<"

[[ -n "${HOME:-}" && -d "$HOME" ]] || { echo "ERROR: Jalankan installer dari Termux." >&2; exit 1; }

printf '\n\033[38;5;51m╔══════════════════════════════════════════════════════╗\033[0m\n'
printf '\033[38;5;201m║          CALZX TERMUX • NEON HACKER EDITION          ║\033[0m\n'
printf '\033[38;5;51m╚══════════════════════════════════════════════════════╝\033[0m\n\n'
printf 'Channel YouTube CALZX:\n%s\n' "$YOUTUBE_URL"
printf 'Jangan lupa dukung kreator dengan subscribe!\n'
read -r -p "Ketik S untuk membuka channel, atau Enter untuk lanjut: " choice || true
if [[ "${choice:-}" =~ ^[sS]$ ]]; then
  if command -v termux-open-url >/dev/null 2>&1; then
    termux-open-url "$YOUTUBE_URL" || echo "Gagal membuka otomatis; buka URL di atas secara manual."
  else
    echo "termux-open-url tidak tersedia; buka URL di atas secara manual."
  fi
  read -r -p "Tekan Enter untuk melanjutkan instalasi: " _ || true
fi

shell_name="$(basename -- "${SHELL:-bash}")"
case "$shell_name" in
  zsh) rc_file="${HOME}/.zshrc" ;;
  *) rc_file="${HOME}/.bashrc" ;;
esac

mkdir -p "$CONFIG_DIR" "$BIN_DIR"
if [[ -f "$rc_file" ]]; then
  backup="${rc_file}.calzx-backup-$(date +%Y%m%d-%H%M%S)"
  cp -p -- "$rc_file" "$backup"
  echo "Cadangan dibuat: $backup"
else
  : > "$rc_file"
fi

if [[ ! -f "${CONFIG_DIR}/config" ]]; then
cat > "${CONFIG_DIR}/config" <<'CONFIG'
# CALZX TERMUX — ubah nilai sesuai selera.
CALZX_TITLE="CALZX"
CALZX_SUBTITLE="NEON HACKER TERMINAL"
CALZX_GREETING="Welcome back, CALZX!"
CALZX_SHOW_INFO="true"
CALZX_RAINBOW="true"
CALZX_SHOW_TIPS="true"
CONFIG
fi

if ! command -v figlet >/dev/null 2>&1; then
  echo "Memasang figlet untuk banner ASCII..."
  if command -v pkg >/dev/null 2>&1; then
    pkg install -y figlet || echo "Figlet gagal dipasang; fallback banner tetap tersedia."
  fi
fi

install -m 755 "${PROJECT_DIR}/bin/calzx" "${BIN_DIR}/calzx"
install -m 755 "${PROJECT_DIR}/bin/calzx-config" "${BIN_DIR}/calzx-config"
install -m 755 "${PROJECT_DIR}/uninstall.sh" "${BIN_DIR}/calzx-uninstall"

tmp_file="$(mktemp)"
awk -v start="$MARKER_START" -v end="$MARKER_END" '
  $0 == start {skip=1; next}
  $0 == end {skip=0; next}
  !skip {print}
' "$rc_file" > "$tmp_file"

{
  cat "$tmp_file"
  [[ ! -s "$tmp_file" ]] || printf '\n'
  printf '%s\n' "$MARKER_START"
  printf '%s\n' 'command -v calzx >/dev/null 2>&1 && calzx'
  printf '%s\n' "$MARKER_END"
} > "${rc_file}.calzx-new"
cat "${rc_file}.calzx-new" > "$rc_file"
rm -f "$tmp_file" "${rc_file}.calzx-new"

printf '\n\033[38;5;46mCALZX TERMUX berhasil dipasang!\033[0m\n'
printf 'Tes: calzx\nEdit: calzx-config\nTutup dan buka kembali Termux untuk mencoba startup otomatis.\n'

#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail
start="# >>> CALZX TERMUX START >>>"
end="# <<< CALZX TERMUX END <<<"
for rc_file in "${HOME}/.bashrc" "${HOME}/.zshrc"; do
  [[ -f "$rc_file" ]] || continue
  grep -Fq "$start" "$rc_file" || continue
  tmp="$(mktemp)"
  awk -v start="$start" -v end="$end" '
    $0 == start {skip=1; next}
    $0 == end {skip=0; next}
    !skip {print}
  ' "$rc_file" > "$tmp"
  cat "$tmp" > "$rc_file"
  rm -f "$tmp"
  echo "Hook startup dihapus dari $rc_file"
done
PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
rm -f "${PREFIX}/bin/calzx" "${PREFIX}/bin/calzx-config" "${PREFIX}/bin/calzx-uninstall"
echo "Skrip CALZX dihapus. Cadangan dan konfigurasi tetap disimpan."
echo "Opsional hapus konfigurasi: rm -r ~/.config/calzx-termux"

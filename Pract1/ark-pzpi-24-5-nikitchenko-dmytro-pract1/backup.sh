#!/usr/bin/env bash
#
# Робить архів теки з датою в назві і кладе його в ~/backups.
# Запуск: ./backup.sh <тека>

set -euo pipefail

readonly BACKUP_DIR="${HOME}/backups"

die() {
  echo "Помилка: $*" >&2
  exit 1
}

# Пакує теку $1 у tar.gz.
make_archive() {
  local src=$1
  local name
  name="$(basename "$src")_$(date +%Y-%m-%d_%H%M%S).tar.gz"

  tar -czf "${BACKUP_DIR}/${name}" -C "$(dirname "$src")" "$(basename "$src")"
  echo "Готово: ${BACKUP_DIR}/${name}"
}

main() {
  [[ $# -eq 1 ]] || die "запуск: $0 <тека>"
  [[ -d $1 ]] || die "теки «$1» не існує"

  mkdir -p "$BACKUP_DIR"
  make_archive "$1"
}

main "$@"

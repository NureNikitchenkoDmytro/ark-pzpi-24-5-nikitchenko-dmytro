#!/usr/bin/env bash
# Чи допущений студент до іспиту: ./admit.sh grades.csv Іваненко
set -u

die() {
  echo "$*" >&2
  exit 1
}

[ $# -eq 2 ] || die "Запуск: $0 <файл> <прізвище>"
[ -f "$1" ] || die "Немає файлу $1"
line=$(grep "^$2," "$1")
[ -n "$line" ] || die "Студента $2 немає у файлі"

if [ $(( ($(echo "$line" | cut -d, -f2) + $(echo "$line" | cut -d, -f3) + $(echo "$line" | cut -d, -f4)) / 3 )) -ge 60 ] && [ "$(echo "$line" | cut -d, -f5)" -le 2 ]; then
  echo "$2: допущений"
else
  echo "$2: не допущений"
fi

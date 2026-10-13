#!/usr/bin/env bash
# Чи допущений студент до іспиту: ./admit.sh grades.csv Іваненко
set -u

MIN_AVERAGE=60    # мінімальний середній бал
MAX_MISSED=2      # максимум пропусків

die() {
  echo "$*" >&2
  exit 1
}

[ $# -eq 2 ] || die "Запуск: $0 <файл> <прізвище>"
[ -f "$1" ] || die "Немає файлу $1"
line=$(grep "^$2," "$1")
[ -n "$line" ] || die "Студента $2 немає у файлі"

IFS=, read -r name lab1 lab2 lab3 missed <<< "$line"
average=$(( (lab1 + lab2 + lab3) / 3 ))

if (( average >= MIN_AVERAGE && missed <= MAX_MISSED )); then
  echo "$name: допущений"
else
  echo "$name: не допущений"
fi

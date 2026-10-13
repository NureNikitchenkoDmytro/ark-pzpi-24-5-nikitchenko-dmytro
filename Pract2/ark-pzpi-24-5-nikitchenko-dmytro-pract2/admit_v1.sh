#!/usr/bin/env bash
# Чи допущений студент до іспиту: ./admit.sh grades.csv Іваненко
set -u

if [ $# -eq 2 ]; then
  if [ -f "$1" ]; then
    line=$(grep "^$2," "$1")
    if [ -n "$line" ]; then
      if [ $(( ($(echo "$line" | cut -d, -f2) + $(echo "$line" | cut -d, -f3) + $(echo "$line" | cut -d, -f4)) / 3 )) -ge 60 ] && [ "$(echo "$line" | cut -d, -f5)" -le 2 ]; then
        echo "$2: допущений"
      else
        echo "$2: не допущений"
      fi
    else
      echo "Студента $2 немає у файлі" >&2
      exit 1
    fi
  else
    echo "Немає файлу $1" >&2
    exit 1
  fi
else
  echo "Запуск: $0 <файл> <прізвище>" >&2
  exit 1
fi

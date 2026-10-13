#!/usr/bin/env bash
# Статистика оцінок з лабораторних: ./stats.sh grades.csv
set -u

students() {          # рядки файлу без заголовка
  tail -n +2 "$1"
}

print_averages() {
  echo "Середні бали:"
  students "$1" | while IFS=, read -r name l1 l2 l3 _; do
    echo "  $name: $(( (l1 + l2 + l3) / 3 ))"
  done
}

best_student() {
  students "$1" \
    | awk -F, '{ print int(($2 + $3 + $4) / 3), $1 }' \
    | sort -rn | head -1 | cut -d' ' -f2
}

count_with_missed() {
  students "$1" | awk -F, '$5 > 0' | wc -l
}

file=$1
print_averages "$file"
echo "Найкращий: $(best_student "$file")"
echo "З пропусками: $(count_with_missed "$file")"

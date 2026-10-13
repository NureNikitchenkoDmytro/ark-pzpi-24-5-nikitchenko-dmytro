#!/usr/bin/env bash
# Статистика оцінок з лабораторних: ./stats.sh grades.csv
set -u
file=$1

# середній бал кожного студента
echo "Середні бали:"
tail -n +2 "$file" | while IFS=, read -r name l1 l2 l3 _; do
  echo "  $name: $(( (l1 + l2 + l3) / 3 ))"
done

# найкращий студент
best=$(tail -n +2 "$file" | awk -F, '{ print int(($2 + $3 + $4) / 3), $1 }' | sort -rn | head -1 | cut -d' ' -f2)
echo "Найкращий: $best"

# скільки студентів мають пропуски
count=$(tail -n +2 "$file" | awk -F, '$5 > 0' | wc -l)
echo "З пропусками: $count"

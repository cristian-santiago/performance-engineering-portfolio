#!/bin/bash
CONTAINER="spring-demo"
OUT="td_$(date +%Y%m%d_%H%M%S).txt"

echo "=== TOP -H ===" > "$OUT"
docker exec "$CONTAINER" top -H -p 1 -b -n 1 >> "$OUT"

echo "" >> "$OUT"
echo "=== THREAD DUMP ===" >> "$OUT"
docker exec "$CONTAINER" jcmd 1 Thread.print >> "$OUT"

echo "Collected in $OUT"

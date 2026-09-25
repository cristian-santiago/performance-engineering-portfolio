#!/bin/bash
CONTAINER="spring-demo"
OUT="td_$(date +%Y%m%d_%H%M%S).txt"
TOP_OUT="top_$(date +%Y%m%d_%H%M%S).txt"


# Collecting top -H and TD in separated files

docker exec "$CONTAINER" top -H -p 1 -b -n 1 > "$TOP_OUT"
docker exec "$CONTAINER" jcmd 1 Thread.print >> "$OUT"

#Join both in a final file

cat "$TOP_OUT" > "$OUT"
echo "" >> "$OUT"
docker exec "$CONTAINER" jcmd 1 Thread.print >> "$OUT"


# Capture the TID that consume more CPU (ignoring header)


# Fallback: If no thread has CPU > 0, it gets the highest TIME+ (collumn 11)
TOP_TID=$(awk 'NR>6 {print $1, $11}' "$TOP_OUT" | sort -k2 -hr | head -1 | awk '{print $1}')


TOP_HEX=$(printf "0x%x" "$TOP_TID")

echo "=== TOP THREAD ==="
echo "TID: $TOP_TID | hex: $TOP_HEX"
echo ""
echo "=== THREAD IN DUMP ==="
grep "nid=$TOP_HEX" "$OUT"

#!/bin/bash

THRESHOLD=80
EMAIL="your-email@example.com"
HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

MEM_TOTAL=$(free -m | awk '/^Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/^Mem:/ {print $3}')

if [[ "$MEM_TOTAL" =~ ^[0-9]+$ && "$MEM_USED" =~ ^[0-9]+$ ]]; then
    USED_MEM_PERCENT=$(( 100 * MEM_USED / MEM_TOTAL ))
else
    echo "Error: Could not determine memory usage."
    exit 1
fi

if [ "$USED_MEM_PERCENT" -ge "$THRESHOLD" ]; then
    SUBJECT="RAM Alert: $USED_MEM_PERCENT% used on $HOSTNAME"
    MESSAGE="RAM usage is at ${USED_MEM_PERCENT}% on $HOSTNAME as of $DATE.\nTotal: ${MEM_TOTAL}MB, Used: ${MEM_USED}MB"
    echo -e "$MESSAGE" | mailx -s "$SUBJECT" "$EMAIL"
else
    echo "RAM usage is normal: ${USED_MEM_PERCENT}%"
fi



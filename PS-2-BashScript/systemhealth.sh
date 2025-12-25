#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
PROCESS_THRESHOLD=300

LOG_FILE="system_health.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "----- Health Check at $DATE -----" >> $LOG_FILE

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
  echo "ALERT: CPU usage is high: ${CPU_USAGE}%" | tee -a $LOG_FILE
fi

# Memory Usage
MEM_USAGE=$(free | awk '/Mem/{printf("%.0f"), $3/$2 * 100}')

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
  echo "ALERT: Memory usage is high: ${MEM_USAGE}%" | tee -a $LOG_FILE
fi

# Disk Usage
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  echo "ALERT: Disk usage is high: ${DISK_USAGE}%" | tee -a $LOG_FILE
fi

# Process Count
PROCESS_COUNT=$(ps -e --no-headers | wc -l)

if [ "$PROCESS_COUNT" -gt "$PROCESS_THRESHOLD" ]; then
  echo "ALERT: High number of running processes: $PROCESS_COUNT" | tee -a $LOG_FILE
fi

echo "Health check completed." >> $LOG_FILE
echo "" >> $LOG_FILE

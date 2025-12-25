#!/bin/bash

APP_URL="https://wisecow.local:8443"
LOG_FILE="app_health.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

HTTP_STATUS=$(curl -k -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "$DATE - Application is UP (HTTP $HTTP_STATUS)" | tee -a $LOG_FILE
else
  echo "$DATE - Application is DOWN (HTTP $HTTP_STATUS)" | tee -a $LOG_FILE
fi

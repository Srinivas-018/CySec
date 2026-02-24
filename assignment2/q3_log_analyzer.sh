#!/bin/bash

#1. Accept log filename as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE=$1
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

if [ ! -s "$LOG_FILE" ]; then
    echo "Log file is empty: $LOG_FILE"
    exit 1
fi
echo ""
echo "=== LOG FILE ANALYSIS ==="
echo "Log File: $LOG_FILE"
echo ""
echo "Total Entries: $(wc -l < "$LOG_FILE")"
echo ""

# Count and display unique IP addresses
count=$(cut -d' ' -f1 "$LOG_FILE" | sort | uniq | wc -l)
echo "Unique IP addresses: $count"
cut -d' ' -f1 "$LOG_FILE" | sort | uniq -c | sort -nr | awk '{print "  - "$2}'
echo ""

# Status Code Summary:
echo "Status Code Summary:"
cut -d' ' -f7 "$LOG_FILE" | sort  |sort -nr |uniq -c |awk '{print "  "$2": "$1" requests"}'
echo ""

# Top 3 IP addresses by number of requests
echo "Top 3 IP addresses by number of requests:"
cut -d' ' -f1 "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 3 | awk '{print "  "NR". "$2" - "$1" requests"}'
echo ""

#Date wise request count
echo "Number of requests per day:"
awk '{print $4}' "$LOG_FILE" | cut -d: -f1 | sort | uniq -c | sort -nr | awk '{print "  - "$2" - "$1" requests"}'
echo ""

#detect security threats: IP addresses with multiple 403 status codes
echo "IP addresses with multiple 403 status codes:"
cut -d' ' -f1,7 "$LOG_FILE" | awk '$2 == 403 {print $1}' | sort | uniq -c | sort -nr | awk '$1 > 1 {print "  - "$2" - "$1" Times"}'
echo ""

#generate CSV report
echo "Generating CSV report: log_report.csv"
{
    echo " IP Address  , Requests"
    cut -d' ' -f1 "$LOG_FILE" | sort | uniq -c | sort -nr | awk '{print $2" , "$1}'
} > log_report.csv
echo "Report generated: log_report.csv"
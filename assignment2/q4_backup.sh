#!/bin/bash

# 1. Source Selection: Ask user which directory to backup
read -r -p "Enter directory to backup: " SOURCE_DIR
#Validate that source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory not found: $SOURCE_DIR"
    exit 1
fi

# 2. Backup Location: Ask where to save backup
read -r -p "Enter backup destination: " BACKUP_DIR
#Create destination directory if it doesn't exist (mkdir -p)
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi
echo ""

# 3. Backup Type: Simple copy (cp) or Compressed archive (tar)
echo "Backup Type:"
echo "1. Simple Copy"
echo "2. Compressed Archive (tar.gz)"
read -r -p "Enter choice: " BACKUP_CHOICE
case $BACKUP_CHOICE in
    1) BACKUP_TYPE="simple" ;;
    2) BACKUP_TYPE="compressed" ;;
    *) echo "Invalid choice: $BACKUP_CHOICE"; exit 1 ;;
esac
echo ""
echo "[*] Starting backup..."
sleep 1
echo "[*] Source: $SOURCE_DIR"
echo "[*] Destination: $BACKUP_DIR"
sleep 1
if [ "$BACKUP_TYPE" == "simple" ]; then
    echo "[*] Creating simple copy ..."
elif [ "$BACKUP_TYPE" == "compressed" ]; then
    echo "[*] Creating compressed archive ..."
fi
echo ""
sleep 1

# 4. Naming: Create backup with timestamp (backup_YYYYMMDD_HHMMSS.tar.gz)
#Use date +%Y%m%d_%H%M%S for timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_${TIMESTAMP}"

#backup log file
LOG_FILE="$BACKUP_DIR/backup_log.txt"

# 5. Verification: Check if backup was successful
if [ "$BACKUP_TYPE" == "simple" ]; then
    if ! cp -r "$SOURCE_DIR" "$BACKUP_DIR/$BACKUP_NAME"; then
        echo "Backup failed during copy."
        exit 1
    fi
elif [ "$BACKUP_TYPE" == "compressed" ]; then
# Use tar -czf for compressed backups
    if ! tar -czf "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"; then
        echo "Backup failed during compression."
        exit 1
    fi
else
    echo "Invalid backup type: $BACKUP_TYPE"
    exit 1
fi

# 6. Summary: Display backup details (size, location, time taken)
#Calculate and display backup size using du -h
if [ "$BACKUP_TYPE" == "simple" ]; then
    BACKUP_SIZE=$(du -hs "$BACKUP_DIR/$BACKUP_NAME" |cut -f1 |awk '{printf "%.2f KB", $1/1024}')
elif [ "$BACKUP_TYPE" == "compressed" ]; then
    BACKUP_SIZE=$(du -hs "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" |awk '{printf "%.2f B", $1}')
else
    BACKUP_SIZE="Unknown"
fi
echo "Backup size is: $BACKUP_SIZE"
echo "Backup completed successfully."
echo ""
sleep 1
echo "Backup Details:"
echo "  File: $BACKUP_NAME"
echo "  Location: $BACKUP_DIR"
echo "  Size: $BACKUP_SIZE"
echo "  Time Taken: $(date -u -d "0 $SECONDS sec" +"%S seconds")"

#old backup deletion except the latest 5 backups from the backup directory
echo "Cleaning up old backups, keeping only the latest 5..."
if [ "$BACKUP_TYPE" == "simple" ]; then
    find "$BACKUP_DIR" -maxdepth 1 -type d -name "backup_*" | sort -r | tail -n +6 | xargs rm -rf
elif [ "$BACKUP_TYPE" == "compressed" ]; then
    find "$BACKUP_DIR" -maxdepth 1 -type f -name "backup_*.tar.gz" | sort -r | tail -n +6 | xargs rm -f
fi
echo "Old backups cleaned up."

#email notification
read -r -p "Enter email address for backup notification: " EMAIL
if [ -n "$EMAIL" ]; then
    echo "Sending backup notification to $EMAIL..."
    FROM_EMAIL="${USER}@$(hostname -f 2>/dev/null)"
    if [ -z "$FROM_EMAIL" ] || [ "$FROM_EMAIL" = "@" ]; then
        FROM_EMAIL="$EMAIL"
    fi
    {
        echo "From: $FROM_EMAIL"
        echo "To: $EMAIL"
        echo "Subject: Backup Completed - $BACKUP_NAME"
        echo "Backup $BACKUP_NAME completed successfully at $(date)."
        echo "Backup Details:"
        echo "  Location: $BACKUP_DIR"
        echo "  Size: $BACKUP_SIZE"
        echo "  Time Taken: $(date -u -d "0 $SECONDS sec" +"%S seconds")"
    } > email.txt
    # Send email using local sendmail (requires local MTA)
    if ! command -v sendmail >/dev/null 2>&1; then
        echo "Failed to send email. 'sendmail' utility not found."
        echo "Email notification skipped: 'sendmail' utility not installed." >> "$LOG_FILE"
    elif sendmail -t < email.txt; then
        echo "Email notification sent to $EMAIL."
        echo "Email notification sent to $EMAIL." >> "$LOG_FILE"
    else
        echo "Failed to send email. Check local MTA configuration."
        echo "Email notification failed. Check local MTA configuration." >> "$LOG_FILE"
    fi
    rm -f email.txt
else
    echo "No email address provided. Skipping email notification."
fi

echo "Logging backup details to $LOG_FILE"
{
    echo "Backup Name: $BACKUP_NAME"
    echo "Location: $BACKUP_DIR"
    echo "Size: $BACKUP_SIZE"
    echo "Time Taken: $(date -u -d "0 $SECONDS sec" +"%S seconds")"
    echo "Backup Type: $BACKUP_TYPE"
    echo "Backup completed on: $(date)"
} >> "$LOG_FILE"
echo "Backup details logged to $LOG_FILE"

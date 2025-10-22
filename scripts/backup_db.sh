#!/bin/bash
# ============================================================
#  Moodle Database Backup Script
#  File: scripts/backup_db.sh
#  Purpose: Automate the process of creating secure and timestamped
#           backups of the Moodle database.
#  Author: {{Your Name}}
#  Last Updated: {{Insert Date}}
# ============================================================

# -------------------------------
# 1. CONFIGURATION VARIABLES
# -------------------------------

# Database connection details
DB_USER="moodleuser"              # Database username
DB_PASS="your_password_here"      # Database password
DB_NAME="moodle"                  # Database name
DB_HOST="localhost"               # Database host (usually localhost)

# Backup destination directory
BACKUP_DIR="/var/backups/moodle/db"

# Number of days to keep old backups
RETENTION_DAYS=14

# Date format for backup file names
DATE=$(date +%Y%m%d_%H%M%S)

# Backup file name (compressed SQL dump)
BACKUP_FILE="${BACKUP_DIR}/moodle_db_backup_${DATE}.sql.gz"

# Log file
LOG_FILE="/var/log/moodle_db_backup.log"

# -------------------------------
# 2. SAFETY CHECKS
# -------------------------------

# Ensure backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Creating backup directory: $BACKUP_DIR" | tee -a $LOG_FILE
  mkdir -p $BACKUP_DIR
fi

# Check for required commands
for cmd in mysqldump gzip find; do
  if ! command -v $cmd &> /dev/null; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Required command '$cmd' not found. Aborting." | tee -a $LOG_FILE
    exit 1
  fi
done

# -------------------------------
# 3. BACKUP PROCESS
# -------------------------------

echo "=========================================" | tee -a $LOG_FILE
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting Moodle DB Backup" | tee -a $LOG_FILE
echo "=========================================" | tee -a $LOG_FILE

# Execute MySQL dump and compress the output
mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME \
  --single-transaction --quick --lock-tables=false | gzip > $BACKUP_FILE

# Check if dump was successful
if [ $? -eq 0 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: Backup created at $BACKUP_FILE" | tee -a $LOG_FILE
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Database backup failed!" | tee -a $LOG_FILE
  exit 1
fi

# -------------------------------
# 4. CLEANUP OLD BACKUPS
# -------------------------------

echo "$(date '+%Y-%m-%d %H:%M:%S') - Removing backups older than ${RETENTION_DAYS} days..." | tee -a $LOG_FILE
find $BACKUP_DIR -type f -name "moodle_db_backup_*.sql.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;
echo "$(date '+%Y-%m-%d %H:%M:%S') - Old backups cleaned." | tee -a $LOG_FILE

# -------------------------------
# 5. PERMISSIONS AND SECURITY
# -------------------------------

# Ensure proper permissions for backup files
chmod 600 $BACKUP_FILE
chown root:root $BACKUP_FILE

# -------------------------------
# 6. SUMMARY
# -------------------------------

echo "$(date '+%Y-%m-%d %H:%M:%S') - Moodle database backup completed successfully." | tee -a $LOG_FILE
echo "Backup file: $BACKUP_FILE" | tee -a $LOG_FILE
echo "Retention policy: $RETENTION_DAYS days" | tee -a $LOG_FILE
echo "=========================================" | tee -a $LOG_FILE

exit 0

# ============================================================
#  HOW TO USE THIS SCRIPT
# ============================================================

# 1. Save this file as scripts/backup_db.sh in your Moodle project.
# 2. Make it executable:
#      chmod +x scripts/backup_db.sh
# 3. Test it manually:
#      ./scripts/backup_db.sh
# 4. Schedule it via cron (example: daily at 2 AM):
#      0 2 * * * /path/to/scripts/backup_db.sh >> /var/log/moodle_db_backup.log 2>&1
# 5. Verify the log file and backups regularly.

# ============================================================
#  NOTES AND BEST PRACTICES
# ============================================================

# - Ensure MySQL user has read-only access to the Moodle database.
# - Store backups on a secure and redundant storage system.
# - Consider encrypting backups for sensitive data.
# - Regularly test restoring a backup to ensure integrity.
# - Integrate with full site backup (see docs/guides/backup.md).
# - Use environment variables or .env files for credentials where possible.

# ============================================================
#  END OF SCRIPT
# ============================================================


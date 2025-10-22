#!/bin/bash
# ============================================================
#  Moodle Maintenance Mode Control Script
#  File: scripts/start_stop_maintenance_mode.sh
#  Purpose: Enable or disable Moodle’s maintenance mode using CLI commands.
#  Author: {{Your Name}}
#  Last Updated: {{Insert Date}}
# ============================================================

# -------------------------------
# 1. CONFIGURATION VARIABLES
# -------------------------------

# Moodle installation path
MOODLE_PATH="/var/www/moodle"

# PHP binary path
PHP_PATH="/usr/bin/php"

# Log file for operations
LOG_FILE="/var/log/moodle_maintenance_mode.log"

# -------------------------------
# 2. SAFETY CHECKS
# -------------------------------

if [ ! -d "$MOODLE_PATH" ]; then
  echo "ERROR: Moodle directory not found at $MOODLE_PATH" | tee -a $LOG_FILE
  exit 1
fi

if [ ! -x "$PHP_PATH" ]; then
  echo "ERROR: PHP binary not found at $PHP_PATH" | tee -a $LOG_FILE
  exit 1
fi

# -------------------------------
# 3. FUNCTION DEFINITIONS
# -------------------------------

enable_maintenance_mode() {
  echo "----------------------------------------" | tee -a $LOG_FILE
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Enabling maintenance mode..." | tee -a $LOG_FILE
  sudo -u www-data $PHP_PATH $MOODLE_PATH/admin/cli/maintenance.php --enable

  if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: Maintenance mode ENABLED." | tee -a $LOG_FILE
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Failed to enable maintenance mode." | tee -a $LOG_FILE
    exit 1
  fi
}

disable_maintenance_mode() {
  echo "----------------------------------------" | tee -a $LOG_FILE
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Disabling maintenance mode..." | tee -a $LOG_FILE
  sudo -u www-data $PHP_PATH $MOODLE_PATH/admin/cli/maintenance.php --disable

  if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: Maintenance mode DISABLED." | tee -a $LOG_FILE
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Failed to disable maintenance mode." | tee -a $LOG_FILE
    exit 1
  fi
}

show_status() {
  echo "----------------------------------------" | tee -a $LOG_FILE
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking current maintenance mode status..." | tee -a $LOG_FILE
  sudo -u www-data $PHP_PATH $MOODLE_PATH/admin/cli/maintenance.php --show
}

# -------------------------------
# 4. SCRIPT MENU
# -------------------------------

case "$1" in
  start)
    enable_maintenance_mode
    ;;
  stop)
    disable_maintenance_mode
    ;;
  status)
    show_status
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    echo "Examples:"
    echo "  $0 start   → Enable maintenance mode"
    echo "  $0 stop    → Disable maintenance mode"
    echo "  $0 status  → Check current status"
    exit 1
    ;;
esac

# -------------------------------
# 5. SUMMARY
# -------------------------------

echo "----------------------------------------" | tee -a $LOG_FILE
echo "$(date '+%Y-%m-%d %H:%M:%S') - Operation completed." | tee -a $LOG_FILE
echo "Moodle Path: $MOODLE_PATH" | tee -a $LOG_FILE
echo "Log File: $LOG_FILE" | tee -a $LOG_FILE
echo "----------------------------------------" | tee -a $LOG_FILE
exit 0

# ============================================================
#  HOW TO USE THIS SCRIPT
# ============================================================

# 1. Save this file as scripts/start_stop_maintenance_mode.sh
# 2. Make it executable:
#      chmod +x scripts/start_stop_maintenance_mode.sh
# 3. Run it manually:
#      ./scripts/start_stop_maintenance_mode.sh start
#      ./scripts/start_stop_maintenance_mode.sh stop
#      ./scripts/start_stop_maintenance_mode.sh status
# 4. You can use this script before performing upgrades, backups, or maintenance tasks.

# ============================================================
#  BEST PRACTICES
# ============================================================

# - Always enable maintenance mode before running database or plugin upgrades.
# - Disable maintenance mode immediately after all tasks are complete.
# - Monitor the log file at /var/log/moodle_maintenance_mode.log for confirmation.
# - You can integrate this script with other automated maintenance scripts,
#   such as backup_db.sh or clean_cache.sh.
# - It is recommended to notify users prior to enabling maintenance mode
#   to prevent data loss or confusion.

# ============================================================
#  END OF SCRIPT
# ============================================================


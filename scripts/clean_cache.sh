#!/bin/bash
# ============================================================
#  Moodle Cache Cleaning Script
#  File: scripts/clean_cache.sh
#  Purpose: Safely clear Moodle’s application, theme, and language caches
#           to ensure consistent performance and visibility of updates.
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
LOG_FILE="/var/log/moodle_cache_cleanup.log"

# -------------------------------
# 2. SAFETY CHECKS
# -------------------------------

echo "=========================================" | tee -a $LOG_FILE
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting Moodle cache cleanup" | tee -a $LOG_FILE
echo "=========================================" | tee -a $LOG_FILE

# Check Moodle directory
if [ ! -d "$MOODLE_PATH" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Moodle path not found at $MOODLE_PATH" | tee -a $LOG_FILE
  exit 1
fi

# Check PHP executable
if [ ! -x "$PHP_PATH" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: PHP executable not found at $PHP_PATH" | tee -a $LOG_FILE
  exit 1
fi

# -------------------------------
# 3. CLEAN CACHE USING MOODLE CLI
# -------------------------------

echo "$(date '+%Y-%m-%d %H:%M:%S') - Cleaning caches using Moodle CLI..." | tee -a $LOG_FILE

# Run Moodle’s built-in cache purge command
sudo -u www-data $PHP_PATH $MOODLE_PATH/admin/cli/purge_caches.php

if [ $? -eq 0 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: Moodle caches purged successfully." | tee -a $LOG_FILE
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Cache purge command failed!" | tee -a $LOG_FILE
  exit 1
fi

# -------------------------------
# 4. OPTIONAL: REMOVE OLD LOCAL CACHE FILES
# -------------------------------

# Manually remove leftover cache directories (optional)
CACHE_DIRS=(
  "$MOODLE_PATH/cache"
  "$MOODLE_PATH/localcache"
  "$MOODLE_PATH/temp"
  "$MOODLE_PATH/sessions"
)

for DIR in "${CACHE_DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Cleaning directory: $DIR" | tee -a $LOG_FILE
    sudo -u www-data find "$DIR" -type f -delete
    sudo -u www-data find "$DIR" -type d -empty -delete
  fi
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Manual cache directories cleaned." | tee -a $LOG_FILE

# -------------------------------
# 5. VERIFY FILE PERMISSIONS
# -------------------------------

# Ensure Moodle directory has proper ownership
sudo chown -R www-data:www-data $MOODLE_PATH
sudo find $MOODLE_PATH -type d -exec chmod 755 {} \;
sudo find $MOODLE_PATH -type f -exec chmod 644 {} \;

echo "$(date '+%Y-%m-%d %H:%M:%S') - Permissions verified and corrected." | tee -a $LOG_FILE

# -------------------------------
# 6. SUMMARY
# -------------------------------

echo "=========================================" | tee -a $LOG_FILE
echo "$(date '+%Y-%m-%d %H:%M:%S') - Moodle cache cleanup completed successfully." | tee -a $LOG_FILE
echo "Moodle path: $MOODLE_PATH" | tee -a $LOG_FILE
echo "Log file: $LOG_FILE" | tee -a $LOG_FILE
echo "=========================================" | tee -a $LOG_FILE
exit 0

# ============================================================
#  HOW TO USE THIS SCRIPT
# ============================================================

# 1. Save this file as scripts/clean_cache.sh
# 2. Make it executable:
#      chmod +x scripts/clean_cache.sh
# 3. Run it manually:
#      ./scripts/clean_cache.sh
# 4. Or schedule it via cron for regular maintenance (example: every Sunday at 3 AM):
#      0 3 * * 0 /path/to/scripts/clean_cache.sh >> /var/log/moodle_cache_cleanup.log 2>&1
# 5. Always check the log file for confirmation or errors.

# ============================================================
#  NOTES AND BEST PRACTICES
# ============================================================

# - Use this script after:
#     * Updating Moodle or plugins
#     * Modifying theme or language strings
#     * Experiencing performance or display issues
#
# - Avoid running during peak usage hours to minimize disruption.
# - Clearing caches frequently helps prevent stale data and broken layouts.
# - The CLI purge_caches.php method is safer than manually deleting cache files.
# - Integrate this script into your maintenance plan (see docs/guides/maintenance.md).

# ============================================================
#  END OF SCRIPT
# ============================================================


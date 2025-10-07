# 💾 Moodle Backup Guide

**File:** `docs/guides/backup.md`  
**Purpose:** Describe procedures for performing, scheduling, and verifying Moodle backups — course level and site/server level — and how to restore from them.  
**Audience:** LMS Administrators, Sysadmins, and Support Staff  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 🔎 Overview

Backups are essential to protect course content, user data and the platform configuration. This guide covers:

- Manual course backups  
- Automated course backups (built-in Moodle)  
- Site-level backups: database, `moodledata` and code  
- Verification, retention and monitoring best practices  
- Restore procedures (course and full-site)  
- Example automation script (cron)

---

## 🎓 1. Course-Level Backups

### 1.1 Manual Course Backup (via UI)

**Purpose:** Create a `.mbz` file for a single course (optionally including user data).

**Steps:**
1. Login as Teacher / Manager / Admin.  
2. Navigate to the course → **Course administration → Backup**.  
3. Select options:
   - Include activities/resources  
   - Include enrolled users (if required)  
   - Include logs (optional)
4. Click **Next**, review, then **Perform backup**.  
5. Download the produced `.mbz` file from the backup area (or let it be stored in Moodle backups directory).

**Tip:** Keep a local copy of critical course backups before big changes (updates, course resets).

---

### 1.2 Automated Course Backups (Moodle built-in)

**Path:** `Site administration → Courses → Backups → Automated backup setup`

**Recommended settings:**

| Setting | Recommendation |
|--------:|---------------|
| Active | Enabled |
| Schedule | Weekly (off-peak hours) |
| Include users | Yes (if user-submitted content must be preserved) |
| Include logs | Optional (increases size) |
| Save to | `/moodledata/backup/auto/` or remote storage |
| Notifications | Email admin on failure |

**Notes:**
- Monitor free disk space before enabling.  
- Periodically test restore of an automated backup.

---

## 🖥️ 2. Site-Level Backups (Server-side)

A full site backup requires three components:

1. **Database dump** (contains site config, course structure, grades).  
2. **moodledata** directory (user files, uploaded resources, SCORM data).  
3. **Moodle code directory** (site code and installed plugins).

Keep all three components in sync for reliable full-site restores.

---

### 2.1 Database Backup (MySQL/MariaDB example)

**Basic mysqldump (prompt for password):**

    mysqldump -u <db_user> -p <moodle_db> > /backups/moodle_db_$(date +%F).sql

**Best practices:**
- Use a DB user with appropriate privileges (not root in production).  
- Store dumps compressed: `gzip /backups/moodle_db_2025-10-06.sql`.  
- Avoid exposing passwords in scripts; use `.my.cnf` or environment variables.

---

### 2.2 moodledata Backup

**Recommended approach:** rsync to a backup location, excluding cache/temp folders.

    rsync -av --delete --exclude='cache/' --exclude='temp/' /var/www/moodledata/ /backups/moodledata_$(date +%F)/

**Notes:**
- Keep permissions consistent and restrict access to backups.  
- Excluding caches reduces size and speeds backup.

---

### 2.3 Moodle Code Backup

Create a compressed archive of the Moodle codebase (excluding uploaded files).

    tar -czf /backups/moodle_code_$(date +%F).tar.gz /var/www/html/moodle/

**Also:** maintain a file that lists installed plugin names and versions (use for rebuilds).

---

## ✅ 3. Verification & Maintenance

### 3.1 Verify Backup Integrity
- Periodically **test-restore** a course (monthly/quarterly).  
- Attempt a full restore in staging at least once per year or before major upgrades.  
- Keep checksums (e.g., `sha256sum`) of backup files to detect corruption.

---

### 3.2 Retention & Storage

| **Backup Type** | **Retention Period** | **Recommended Storage Location** | **Notes** |
|-----------------|---------------------:|----------------------------------|------------|
| Course `.mbz` | 6 months (or per policy) | Local + off-site | Keep critical course versions before resets or upgrades. |
| Automated course backups | 4 weeks | Moodle server | Enable rotation to manage disk usage. |
| Site backups (DB + moodledata + code) | 12 months | Secure off-site or cloud | Use encrypted storage and test periodically. |
| Temporary test backups | 1 week | Local temporary directory | Delete automatically via cron. |

**Additional recommendations:**
- Rotate backups automatically using a retention policy.  
- Store at least one copy in a geographically separate location.  
- Encrypt backups containing personal data (GDPR compliance).  

---

### 3.3 Monitoring
- Enable email notifications for backup success/failure.  
- Log backup runs in a maintenance log (`docs/logs/maintenance_log.md`).  
- Monitor disk space, inode usage and backup durations.

---

## 🔁 4. Restore Procedures

### 4.1 Course Restore (UI)
1. Site admin or teacher with restore rights: **Course administration → Restore**.  
2. Upload or select a `.mbz` file.  
3. Choose to restore into a new course or existing course.  
4. Follow the wizard and verify restored content and settings.

### 4.2 Full Site Restore (advanced)
**Note:** Full site restores are invasive and usually done by sysadmins on a separate server or in disaster recovery scenarios.

Basic steps:
1. Put current site into maintenance mode.  
2. Restore database from SQL dump:

    mysql -u <db_user> -p <moodle_db> < /backups/moodle_db_YYYY-MM-DD.sql

3. Restore `moodledata` (rsync or copy) and set correct permissions/ownership.  
4. Restore Moodle code directory (untar archive).  
5. Ensure `config.php` has correct DB credentials and paths.  
6. Purge caches and run upgrade if necessary:

    php /var/www/html/moodle/admin/cli/purge_caches.php
    php /var/www/html/moodle/admin/cli/upgrade.php

7. Test logins, sample courses and cron tasks before reopening.

---

## 🛠️ 5. Automation Example (weekly cron script)

Save this script as `/usr/local/bin/moodle_site_backup.sh` and secure it. **Adapt paths and credentials**.

    #!/bin/bash
    set -euo pipefail
    DATE=$(date +%F)
    BACKUP_ROOT="/backups/moodle_full_${DATE}"
    mkdir -p "${BACKUP_ROOT}"

    # Database (uses .my.cnf or prompt for password)
    mysqldump -u dbuser moodle_db > "${BACKUP_ROOT}/moodle_db_${DATE}.sql"

    # Moodledata (exclude cache/temp)
    rsync -a --delete --exclude='cache/' --exclude='temp/' /var/www/moodledata/ "${BACKUP_ROOT}/moodledata/"

    # Moodle code
    tar -czf "${BACKUP_ROOT}/moodle_code_${DATE}.tar.gz" /var/www/html/moodle/

    # Compress full bundle (optional)
    tar -czf "/backups/moodle_full_${DATE}.tar.gz" -C "/backups" "moodle_full_${DATE}"

    # Remove temporary folder if desired
    rm -rf "${BACKUP_ROOT}"

    # Remove backups older than 90 days
    find /backups/ -maxdepth 1 -type f -mtime +90 -name 'moodle_full_*.tar.gz' -delete

**Cron example (run weekly at 02:00 Sun):**

    0 2 * * 0 /usr/local/bin/moodle_site_backup.sh >> /var/log/moodle_backup.log 2>&1

---

## 🔒 6. Security & Best Practices

- Never store DB credentials in plain text in public repos. Use `.my.cnf` or environment variables with strict permissions.  
- Restrict access to backup storage (RBAC, ACLs, encryption at rest).  
- Scan backup files for malware if third-party content is involved.  
- Keep backups immutable where possible (prevent accidental deletion).

---

## 🧾 7. Documentation & Reporting

Record each backup operation in an administration log including:
- Date/time, responsible person, backup type, location, and verification status.  
- Link to restore test results and any anomalies.  
Store this log in `docs/logs/maintenance_log.md` or in your ticketing system.

---

## ✅ 8. Quick Summary Checklist

| **Task** | **Frequency** | **Responsible** | **Notes** |
|-----------|--------------:|-----------------|------------|
| Manual course backup before big changes | As needed | Course Admin | Always keep before resets or updates. |
| Automated course backups enabled | Weekly | LMS Admin | Verify notification emails are active. |
| Database backup | Daily | Sysadmin | Store in secure, versioned directory. |
| moodledata backup | Daily | Sysadmin | Exclude caches to optimize. |
| Code backup | Weekly | Sysadmin | Archive and compress regularly. |
| Test restore (course) | Monthly | QA / LMS Admin | Ensure `.mbz` integrity. |
| Test full restore (staging) | Yearly or before major upgrade | Sysadmin / QA | Validate complete DR process. |

---

## 📚 References & Further Reading
- Moodle Docs: *Automated course backup and restore*.  
- Your organization’s backup & retention policy.

---

**End of Guide**


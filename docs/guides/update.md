# 🔄 Moodle Update Guide

**File:** `docs/guides/update.md`  
**Purpose:** Provide a complete, step-by-step guide for safely updating Moodle to a new version.  
**Audience:** Moodle administrators and IT staff responsible for platform maintenance.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 🧭 1. Overview

This guide explains how to **update Moodle** (core system, plugins, and dependencies) while ensuring data integrity and minimizing downtime.  
It covers **pre-update preparation, database backup, version compatibility checks, and post-update verification**.

Regular updates are essential for performance improvements, bug fixes, and security patches.

---

## ⚙️ 2. Types of Moodle Updates

| **Type** | **Description** | **Example** |
|-----------|----------------|--------------|
| **Minor Update** | Bug and security fixes within the same major release. | 4.3.1 → 4.3.3 |
| **Major Update** | Upgrade to a new release with new features and database changes. | 4.3 → 4.4 |
| **Plugin Update** | Individual plugin or theme version updates. | Adaptable 3.11.0 → 3.11.2 |

---

## 🧰 3. Pre-Update Checklist

Before performing any update, complete the following:

| ✅ | **Task** |
|----|-----------|
| ☐ Review Moodle release notes and compatibility matrix. |
| ☐ Verify PHP, database, and OS versions meet new requirements. |
| ☐ Put the site into maintenance mode. |
| ☐ Perform a full backup (database, Moodle code, and moodledata). |
| ☐ Disable non-essential plugins. |
| ☐ Notify users about the planned downtime. |
| ☐ Prepare a staging environment for testing. |

---

## 🧱 4. System Requirements Check

Run the Moodle environment check tool:

`Site administration → Server → Environment`

Ensure all components meet the minimum requirements for the target version.  
Pay attention to:
- PHP version  
- Database version (MySQL, MariaDB, PostgreSQL)  
- PHP extensions (intl, xmlrpc, soap, etc.)  
- File permissions  

---

## 💾 5. Backup Before Update

### 5.1 Database Backup
```bash
mysqldump -u root -p moodle > /backups/moodle_db_$(date +%F).sql
```

### 5.2 Moodle Code Backup
```bash
tar -czf /backups/moodle_code_$(date +%F).tar.gz /var/www/moodle
```

### 5.3 Moodledata Backup
```bash
tar -czf /backups/moodledata_$(date +%F).tar.gz /var/moodledata
```

Verify all backups are complete and restorable before continuing.

---

## 🔒 6. Maintenance Mode

Enable maintenance mode before the update to prevent user access:

**Via Web Interface:**  
`Site administration → Server → Maintenance mode`

**Or via CLI:**  
```bash
php admin/cli/maintenance_mode.php --enable
```

---

## 🆙 7. Updating Moodle Core

### 7.1 Replace Moodle Codebase

1. Navigate to your web directory:
   ```bash
   cd /var/www/
   ```
2. Rename the old Moodle folder:
   ```bash
   mv moodle moodle_old
   ```
3. Download the latest stable version:
   ```bash
   git clone -b MOODLE_404_STABLE git://git.moodle.org/moodle.git moodle
   ```
   *(Replace `MOODLE_404_STABLE` with your desired branch)*  
4. Copy your original `config.php` into the new folder:
   ```bash
   cp /var/www/moodle_old/config.php /var/www/moodle/
   ```
5. Copy any custom plugins or themes manually if compatible.

---

## 🧩 8. Update Plugins

1. Visit [https://moodle.org/plugins](https://moodle.org/plugins)  
2. Check compatibility with the new Moodle version.  
3. Download and replace plugin folders inside `/mod`, `/blocks`, or `/theme`.  
4. Run the plugin upgrade script via CLI:
   ```bash
   php admin/cli/upgrade.php
   ```

---

## 🧠 9. Database Upgrade

Once files are updated, upgrade the database schema:

```bash
php admin/cli/upgrade.php
```

Follow the on-screen instructions and confirm the upgrade process.  
All database changes and plugin updates will be applied automatically.

---

## 🔍 10. Post-Update Verification

After completing the upgrade:

| **Check Area** | **Verification Step** |
|----------------|-----------------------|
| **Login test** | Log in as admin and verify access. |
| **Plugins** | Confirm all installed plugins work properly. |
| **Theme** | Ensure the theme renders without layout issues. |
| **Cron** | Run `php admin/cli/cron.php` and check for errors. |
| **Performance** | Monitor page load and resource usage. |

---

## 🔧 11. Clear Cache

After updating, clear all Moodle caches:

**Via Web Interface:**  
`Site administration → Development → Purge all caches`

**Via CLI:**  
```bash
php admin/cli/purge_caches.php
```

---

## 🚀 12. Disable Maintenance Mode

Once verified, disable maintenance mode:

```bash
php admin/cli/maintenance_mode.php --disable
```

Announce to users that the platform is back online.

---

## 🧾 13. Troubleshooting Common Issues

| **Issue** | **Possible Cause** | **Solution** |
|------------|--------------------|---------------|
| White screen after update | PHP error or missing extension | Check `/var/www/moodle/error.log` |
| Plugin compatibility error | Outdated plugin version | Update or disable the plugin |
| Missing theme layout | Incompatible theme | Switch to default Boost theme |
| Database upgrade failure | Incomplete permissions | Ensure DB user has ALTER/CREATE privileges |

---

## 🧪 14. Testing the Upgrade

Perform thorough testing before going live:

| **Test Category** | **Example Tasks** |
|--------------------|-------------------|
| Course Access | Open sample courses and activities |
| User Roles | Verify permissions for admin, teacher, and student |
| File Upload | Test file uploads and backups |
| Messaging | Send a test message between users |
| Reports | Run gradebook and logs reports |

If testing passes in staging, proceed to production.

---

## 🗓️ 15. Routine Update Schedule

| **Frequency** | **Task** | **Notes** |
|----------------|----------|-----------|
| Monthly | Apply minor updates | Security and bug fixes |
| Quarterly | Update plugins | Review compatibility |
| Annually | Major version upgrade | Plan with sufficient downtime |

---

## 🧩 16. Rollback Procedure

If something goes wrong:

1. Enable maintenance mode.  
2. Restore from backups:
   ```bash
   mysql -u root -p moodle < /backups/moodle_db_<date>.sql
   tar -xzf /backups/moodle_code_<date>.tar.gz -C /var/www/
   tar -xzf /backups/moodledata_<date>.tar.gz -C /var/
   ```
3. Verify functionality and user access.  
4. Diagnose and correct the cause before retrying the update.

---

## 📚 17. References

- [Official Moodle Upgrade Documentation](https://docs.moodle.org/en/Upgrading)  
- [Moodle Release Notes](https://moodledev.io/general/releases)  
- [Moodle Plugin Compatibility Database](https://moodle.org/plugins/)  
- [Moodle Git Repository](https://git.moodle.org/gw?p=moodle.git)  

---

**End of Guide**


# 🛠️ Moodle Technical Maintenance Guide

**File:** `docs/guides/maintenance.md`  
**Purpose:** Provide a complete technical maintenance guide for Moodle administrators.  
**Audience:** System administrators and IT staff responsible for Moodle infrastructure.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 📋 1. Overview

This guide outlines the best practices and procedures for maintaining a Moodle installation to ensure **optimal performance**, **security**, and **reliability**.  
It includes daily, weekly, and quarterly maintenance tasks, as well as troubleshooting and optimization recommendations.

---

## ⚙️ 2. Maintenance Goals

| **Goal** | **Description** |
|-----------|----------------|
| **System stability** | Keep Moodle running smoothly without downtime or performance degradation. |
| **Security** | Apply patches and updates promptly to protect data and users. |
| **Performance optimization** | Monitor server load, caching, and database performance. |
| **Backup integrity** | Verify that backups are correctly performed and restorable. |
| **Data management** | Clean up temporary files, old logs, and unused course data. |

---

## 📆 3. Maintenance Schedule

| **Frequency** | **Tasks** |
|----------------|-----------|
| **Daily** | Monitor logs, check disk space, confirm backup completion, verify site uptime. |
| **Weekly** | Optimize database, update plugins if safe, purge caches, review cron job execution. |
| **Monthly** | Apply Moodle core updates, check SSL certificate validity, review user accounts. |
| **Quarterly** | Audit performance, review theme compatibility, test full backup restoration. |

---

## 🧰 4. Pre-Maintenance Preparation

Before performing maintenance, always:

1. **Notify users** of scheduled downtime.  
2. **Put Moodle into Maintenance Mode**  
   ```bash
   php admin/cli/maintenance.php --enable
   ```
3. **Perform a complete backup** (files + database).  
4. **Verify system resource availability** (RAM, CPU, storage).  
5. **Ensure SSH and SFTP access** to the server.

---

## 🔄 5. Moodle Updates and Patches

Keeping Moodle updated ensures security and compatibility.

### 5.1 Check for Updates
Navigate to:  
`Site administration → Notifications`  
or run:
```bash
php admin/cli/checks.php
```

### 5.2 Apply Updates via CLI
1. Download the latest Moodle version compatible with your setup.  
2. Extract it and replace the current Moodle directory:
   ```bash
   mv moodle moodle_old
   unzip moodle-latest.zip -d /var/www/
   mv /var/www/moodle-latest /var/www/moodle
   ```
3. Copy back your configuration:
   ```bash
   cp /var/www/moodle_old/config.php /var/www/moodle/
   ```
4. Run the database upgrade:
   ```bash
   php admin/cli/upgrade.php
   ```
5. Disable maintenance mode after completion:
   ```bash
   php admin/cli/maintenance.php --disable
   ```

---

## 🧹 6. Database and File Cleanup

Over time, Moodle stores large amounts of logs and temporary data. Regular cleanup improves performance.

| **Area** | **Action** | **Command/Path** |
|-----------|-------------|------------------|
| Temporary files | Delete unused temp files | `php admin/cli/purge_caches.php` |
| Logs | Set retention policies | `Site administration → Server → Cleanup` |
| Recycle bin | Empty old course content | `Site administration → Courses → Recycle bin` |
| Sessions | Delete stale sessions | `mdl_sessions` table cleanup |
| Cron jobs | Ensure execution | `php admin/cli/cron.php` |

---

## 🚀 7. Performance Optimization

| **Component** | **Recommendation** |
|----------------|--------------------|
| **Caching** | Enable Redis or Memcached caching in `config.php`. |
| **Database** | Optimize tables weekly with:  
  ```bash
  mysqlcheck -o moodle_database_name
  ``` 
| **OPcache** | Ensure PHP OPcache is enabled for faster script execution. |
| **Cron jobs** | Schedule every minute using `crontab -e`:  
  ```bash
  * * * * * /usr/bin/php /var/www/moodle/admin/cli/cron.php >/dev/null 2>&1
  ``` 
| **File storage** | Use external storage (e.g., AWS S3, NFS) for scalability. |

---

## 🔒 8. Security Maintenance

| **Task** | **Description** |
|-----------|----------------|
| **Apply security patches** | Check Moodle Security Announcements regularly. |
| **Review user roles** | Ensure users have appropriate permissions. |
| **Use HTTPS** | Configure SSL/TLS for all traffic. |
| **Database security** | Use strong credentials and limit remote access. |
| **File permissions** |  
  ```bash
  find /var/www/moodle -type f -exec chmod 644 {} \;
  find /var/www/moodle -type d -exec chmod 755 {} \;
  ``` 
| **Disable directory browsing** | In Apache/Nginx configuration, set `Options -Indexes`. |

---

## 🧩 9. Plugin and Theme Maintenance

1. Regularly review installed plugins:  
   `Site administration → Plugins → Plugins overview`
2. Remove unused or outdated plugins.  
3. Check for plugin compatibility before updates.  
4. Document every plugin version and update date.  
5. For themes, test design consistency after each Moodle upgrade.

---

## 🧾 10. Log and Monitoring Review

| **Tool/Path** | **Purpose** |
|----------------|-------------|
| `Site administration → Reports → Logs` | User activity and course events. |
| `/var/log/nginx/error.log` or `/var/log/apache2/error.log` | Web server errors. |
| `/var/log/mysql/error.log` | Database errors. |
| Moodle’s Event Logging | System-level error detection. |
| Monitoring tools | Set up with Prometheus, Grafana, or New Relic. |

---

## 📦 11. Backups Verification

| **Type** | **Action** | **Frequency** |
|-----------|-------------|----------------|
| **Course backups** | Verify automatic course backups are enabled and completed successfully. | Weekly |
| **Database backup** | Test restoration on a staging server. | Monthly |
| **File backup** | Check file integrity using `rsync` or checksum validation. | Weekly |

---

## 🧰 12. Post-Maintenance Steps

After maintenance:

1. Disable maintenance mode:
   ```bash
   php admin/cli/maintenance.php --disable
   ```
2. Purge all caches:
   ```bash
   php admin/cli/purge_caches.php
   ```
3. Review site functionality (login, course access, file uploads).  
4. Notify users that the system is back online.  
5. Document all maintenance actions performed.

---

## 🧾 13. Maintenance Checklist

| ✅ | **Task** |
|----|-----------|
| ☐ System backed up before changes |
| ☐ Maintenance mode enabled |
| ☐ Moodle core updated |
| ☐ Plugins and themes verified |
| ☐ Database optimized |
| ☐ Logs reviewed |
| ☐ Caches purged |
| ☐ Maintenance mode disabled |
| ☐ Site functionality tested |
| ☐ Maintenance actions documented |

---

## 📚 14. References

- [Moodle Maintenance Documentation](https://docs.moodle.org/en/Site_maintenance)  
- [Moodle Cron Documentation](https://docs.moodle.org/en/Cron)  
- [Moodle Security Guidelines](https://docs.moodle.org/en/Security)  
- [Moodle Performance Recommendations](https://docs.moodle.org/en/Performance_recommendations)

---

**End of Guide**


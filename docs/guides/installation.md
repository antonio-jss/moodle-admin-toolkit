# ⚙️ Moodle Installation Guide

**File:** `docs/guides/installation.md`  
**Purpose:** Provide a detailed, step-by-step guide for installing Moodle in a secure, efficient, and scalable way.  
**Audience:** System administrators, IT staff, and Moodle infrastructure engineers.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 📋 1. Overview

This guide outlines how to install Moodle on a Linux-based environment (recommended).  
The process covers system requirements, server setup, database configuration, and post-installation steps.

You can adapt this procedure for Windows or containerized environments as needed.

---

## 🧩 2. Prerequisites

Before starting, ensure you have:

| **Requirement** | **Minimum Specification** | **Recommendation** |
|------------------|---------------------------|--------------------|
| Operating System | Ubuntu 22.04 LTS or Debian 12 | Any stable LTS Linux distro |
| Web Server | Apache 2.4 or Nginx 1.18+ | Nginx for performance |
| PHP | 8.1 or higher | 8.3 (if supported by your Moodle version) |
| Database | MySQL 8.0 / MariaDB 10.6+ / PostgreSQL 13+ | PostgreSQL for better concurrency |
| Disk Space | 10 GB minimum | 50+ GB recommended for production |
| Memory (RAM) | 2 GB minimum | 4–8 GB recommended |
| Access | SSH and sudo privileges | Required for installation |

---

## 🔧 3. Server Preparation

Run all commands as a privileged user or with `sudo`.

### 3.1 Update the system
```bash
sudo apt update && sudo apt upgrade -y
```

### 3.2 Install required packages
```bash
sudo apt install apache2 mariadb-server php php-cli php-fpm php-xmlrpc php-gd php-intl php-json php-mbstring php-mysql php-xml php-zip php-curl git unzip graphviz aspell ghostscript -y
```

### 3.3 Enable required Apache modules
```bash
sudo a2enmod rewrite ssl headers env dir mime
sudo systemctl restart apache2
```

---

## 🗄️ 4. Database Configuration

### 4.1 Secure MariaDB installation
```bash
sudo mysql_secure_installation
```

### 4.2 Create the Moodle database and user
```bash
sudo mysql -u root -p
```
```sql
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

## 📦 5. Downloading Moodle

### 5.1 Clone the latest stable release
```bash
cd /var/www/
sudo git clone -b MOODLE_404_STABLE git://git.moodle.org/moodle.git
```

> Replace `MOODLE_404_STABLE` with the version branch you need (e.g., `MOODLE_405_STABLE`).

### 5.2 Set permissions
```bash
sudo chown -R www-data:www-data /var/www/moodle
sudo chmod -R 755 /var/www/moodle
```

### 5.3 Create the Moodle data directory
```bash
sudo mkdir /var/moodledata
sudo chown -R www-data:www-data /var/moodledata
sudo chmod -R 770 /var/moodledata
```

---

## 🌐 6. Web Server Configuration

### 6.1 Create a new Apache virtual host
```bash
sudo nano /etc/apache2/sites-available/moodle.conf
```

**Example configuration:**
```apache
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/moodle
    ServerName moodle.example.com

    <Directory /var/www/moodle>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/moodle_error.log
    CustomLog ${APACHE_LOG_DIR}/moodle_access.log combined
</VirtualHost>
```

### 6.2 Enable the site and restart Apache
```bash
sudo a2ensite moodle.conf
sudo systemctl reload apache2
```

---

## 🧰 7. Web-Based Installation Wizard

1. Open a browser and visit:  
   **`http://your-domain.com`**
2. Follow the Moodle installation wizard:
   - Select **language**.  
   - Confirm **paths** (`/var/www/moodle` and `/var/moodledata`).  
   - Choose **database driver** (MySQL, PostgreSQL, etc.).  
   - Enter the credentials created earlier.  
   - Proceed until setup completes.  

3. After installation, Moodle will generate a configuration file:
   ```
   /var/www/moodle/config.php
   ```

---

## 🔐 8. Post-Installation Security

| **Action** | **Command / Setting** | **Purpose** |
|-------------|-----------------------|--------------|
| Secure config.php | `chmod 640 /var/www/moodle/config.php` | Prevents unauthorized access. |
| Configure HTTPS | Install SSL (Let's Encrypt recommended). | Encrypts traffic and logins. |
| Disable directory listing | Apache config: `Options -Indexes` | Prevents file enumeration. |
| Update file permissions | Ensure `moodledata` is not web-accessible. | Protects user data. |
| Enable firewall | `ufw allow 'Apache Full' && ufw enable` | Restricts unwanted traffic. |

---

## 🧭 9. Cron Setup

Moodle requires a background cron job for key processes (enrollments, grades, notifications, etc.).

```bash
sudo crontab -u www-data -e
```

Add the following line:
```bash
* * * * * /usr/bin/php /var/www/moodle/admin/cli/cron.php >/dev/null 2>&1
```

This runs every minute — the recommended interval.

---

## 🧩 10. Performance Optimization

| **Component** | **Recommendation** |
|----------------|--------------------|
| PHP Opcache | Enable and configure in `php.ini` for faster performance. |
| Caching | Configure Moodle Universal Cache (MUC). |
| Database Indexes | Regularly analyze and optimize tables. |
| CDN | Use a CDN for static assets if applicable. |
| Cron Timing | Ensure cron runs every minute as above. |

---

## 📦 11. Upgrading Moodle (Future Maintenance)

To update Moodle later:

```bash
cd /var/www/moodle
sudo git pull
sudo php admin/cli/upgrade.php
```

> Always back up your database and `moodledata` before upgrading.

---

## 🧰 12. Troubleshooting

| **Issue** | **Possible Cause** | **Fix** |
|------------|--------------------|----------|
| “Data directory not writable” | Wrong permissions | Run `chown -R www-data:www-data /var/moodledata` |
| “Error connecting to database” | Wrong credentials | Verify `config.php` and database settings |
| “Blank page” | PHP error | Check Apache logs (`/var/log/apache2/error.log`) |
| Slow performance | Insufficient memory or caching disabled | Tune PHP and database configuration |

---

## 🧾 13. Verification Checklist

| ✅ | **Task** |
|----|-----------|
| ☐ Moodle accessible at domain |
| ☐ HTTPS enabled |
| ☐ Admin user created |
| ☐ Cron running successfully |
| ☐ Backups scheduled |
| ☐ Email notifications working |
| ☐ File permissions correctly applied |

---

## 📚 14. References

- [Official Moodle Installation Docs](https://docs.moodle.org/en/Installing_Moodle)  
- [Moodle Git Repository](https://git.moodle.org/gw)  
- [Moodle Security Recommendations](https://docs.moodle.org/en/Security)  
- [Performance Recommendations](https://docs.moodle.org/en/Performance_recommendations)

---

**End of Guide**

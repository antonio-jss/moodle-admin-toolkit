# 🔐 Moodle Cybersecurity Guide

**File:** `docs/guides/security.md`  
**Purpose:** Provide a comprehensive guide to cybersecurity best practices for Moodle administrators.  
**Audience:** Moodle system administrators, IT security officers, and infrastructure managers.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 📋 1. Overview

This guide outlines **cybersecurity measures and best practices** for securing a Moodle installation, protecting both system integrity and user data.  
It covers server configuration, authentication, data protection, monitoring, and incident response.

Moodle, as a web-based LMS, must be protected against unauthorized access, data leaks, and other vulnerabilities that could compromise educational data.

---

## 🧱 2. Core Security Principles

| **Principle** | **Description** |
|----------------|----------------|
| **Least Privilege** | Users and services should only have the permissions they absolutely need. |
| **Defense in Depth** | Combine multiple layers of security (server, network, application). |
| **Regular Updates** | Keep Moodle core, plugins, OS, and dependencies updated. |
| **Secure Defaults** | Use the most restrictive settings by default. |
| **Audit and Monitoring** | Constantly observe system and user activity for irregularities. |

---

## 🔒 3. Server Security

### 3.1 Operating System Hardening

| **Action** | **Command/Tool** |
|-------------|------------------|
| Apply OS updates | `sudo apt update && sudo apt upgrade` |
| Disable unused services | `systemctl disable <service_name>` |
| Configure firewall | Use `ufw` or `firewalld` to restrict access to only required ports (80, 443, 22). |
| Enforce SSH key authentication | Disable password-based SSH logins. |
| Use fail2ban or intrusion prevention | `sudo apt install fail2ban` |

### 3.2 File Permissions
Ensure correct permissions and ownership for Moodle directories:
```bash
sudo chown -R www-data:www-data /var/www/moodle
find /var/www/moodle -type f -exec chmod 644 {} \;
find /var/www/moodle -type d -exec chmod 755 {} \;
```

Never allow write permissions on the Moodle code directory by other users.

---

## 🧰 4. Moodle Configuration Security

### 4.1 Configuration File
Restrict access to `config.php`:
```bash
chmod 640 /var/www/moodle/config.php
```

### 4.2 Disable Directory Listing
In Apache:
```bash
Options -Indexes
```

### 4.3 Disable Unused Features
- Disable **web services** if not used.  
- Disable **guest access** if not required.  
- Restrict file uploads to trusted users only.

### 4.4 Enforce Secure Cookies and HTTPS
In `config.php`:
```php
$CFG->cookiesecure = true;
$CFG->cookiehttponly = true;
$CFG->wwwroot = 'https://yourmoodlesite.com';
```

Install and maintain valid SSL/TLS certificates (e.g., via Let’s Encrypt).

---

## 👥 5. User Authentication & Account Security

| **Measure** | **Description** |
|--------------|----------------|
| **Password policies** | Enforce strong password requirements and expiration. |
| **Two-Factor Authentication (2FA)** | Enable via Moodle plugin or integrated authentication. |
| **Limit login attempts** | Set a lockout threshold for repeated failed logins. |
| **Session control** | Configure automatic logout after inactivity. |
| **Account audits** | Regularly review active and suspended users. |

In Moodle:  
`Site administration → Security → Site policies`

---

## 📦 6. Plugin and Theme Security

1. Install plugins **only from trusted sources** ([moodle.org/plugins](https://moodle.org/plugins)).  
2. Always review plugin code and compatibility before installation.  
3. Keep plugins updated via:  
   `Site administration → Plugins → Plugins overview`
4. Remove unused or outdated plugins.  
5. Monitor for **third-party vulnerabilities** using CVE databases.

---

## 🧠 7. Data Protection and Privacy

| **Area** | **Best Practice** |
|-----------|-------------------|
| **Personal Data** | Store only data required for educational operations. |
| **Backups** | Encrypt and store securely offsite. |
| **Database access** | Restrict access by user and IP. |
| **GDPR compliance** | Enable Moodle’s privacy features for user consent and data export. |
| **Logs** | Rotate logs regularly and store securely. |

Database encryption example (MySQL):
```bash
ALTER TABLE mdl_user MODIFY email VARBINARY(255);
```

---

## 🔍 8. Monitoring and Intrusion Detection

| **Component** | **Tool/Method** | **Purpose** |
|----------------|----------------|--------------|
| **Web server logs** | `/var/log/apache2/access.log`, `/error.log` | Detect anomalies or attacks. |
| **Moodle logs** | `Site administration → Reports → Logs` | Track user and system events. |
| **File integrity** | `Tripwire`, `AIDE` | Detect unauthorized file changes. |
| **Resource monitoring** | `htop`, `netstat`, `iostat` | Detect suspicious performance spikes. |
| **Centralized logging** | Use `rsyslog` or `ELK Stack` | Aggregate and analyze logs. |

---

## 🧩 9. Security Updates and Patch Management

| **Task** | **Frequency** | **Action** |
|-----------|---------------|------------|
| Moodle core updates | Monthly | Run CLI upgrade and test on staging. |
| Plugin updates | Monthly | Review and update trusted plugins. |
| OS security patches | Weekly | Apply via system package manager. |
| SSL renewal | Every 90 days (Let’s Encrypt) | Automate renewal with cron. |

---

## 🧱 10. Database and Application Security

| **Best Practice** | **Description** |
|--------------------|----------------|
| Use a dedicated DB user | Moodle DB should have only necessary privileges. |
| Enforce SSL connections | Require encrypted MySQL/MariaDB connections. |
| Sanitize inputs | Rely on Moodle’s built-in parameter validation APIs. |
| Enable query logging | Monitor for unexpected access patterns. |

Example MySQL permission setup:
```sql
CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON moodle.* TO 'moodleuser'@'localhost';
FLUSH PRIVILEGES;
```

---

## 🚨 11. Incident Response

### 11.1 Immediate Steps
1. **Isolate the system** from the network if compromised.  
2. **Notify IT Security** and management teams.  
3. **Preserve evidence** (logs, database snapshots, system state).  
4. **Restore from backup** only after thorough analysis.  

### 11.2 Post-Incident Review
- Analyze the root cause.  
- Update configurations, firewalls, or patches.  
- Document all actions taken.  
- Revise internal security policies if needed.  

---

## 🔁 12. Backup and Recovery Security

| **Area** | **Recommendation** |
|-----------|-------------------|
| **Backup frequency** | Daily database + weekly full file system. |
| **Backup storage** | Store on a separate secure server or encrypted cloud. |
| **Access control** | Restrict backup file access to administrators only. |
| **Test restoration** | Verify backups can be successfully restored. |
| **Encryption** | Use GPG or AES encryption for sensitive backups. |

Backup encryption example:
```bash
tar -czf moodle_backup.tar.gz /var/www/moodle
gpg -c moodle_backup.tar.gz
```

---

## 🧾 13. Security Audit Checklist

| ✅ | **Task** |
|----|-----------|
| ☐ Moodle version up to date |
| ☐ All plugins verified and updated |
| ☐ HTTPS enforced and SSL valid |
| ☐ Strong password and 2FA policies enabled |
| ☐ File and folder permissions hardened |
| ☐ Database access restricted |
| ☐ Regular backups verified |
| ☐ Logs monitored and archived |
| ☐ Security incident response plan tested |
| ☐ Privacy and GDPR settings reviewed |

---

## 📚 14. References

- [Moodle Security Documentation](https://docs.moodle.org/en/Security)  
- [Moodle GDPR Compliance Guide](https://docs.moodle.org/en/GDPR)  
- [Moodle Server Hardening Guidelines](https://docs.moodle.org/en/Security_recommendations)  
- [OWASP Top 10 Web Application Security Risks](https://owasp.org/www-project-top-ten/)  
- [Linux Server Hardening Checklist](https://cisecurity.org/)

---

**End of Guide**


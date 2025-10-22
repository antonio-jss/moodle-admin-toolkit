# 🔌 Moodle Plugin Installation Guide

**File:** `docs/guides/installation_plugin.md`  
**Purpose:** Provide a clear, step-by-step guide for installing, updating, and managing Moodle plugins.  
**Audience:** Moodle administrators and technical staff.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 📋 1. Overview

This guide explains how to install plugins in Moodle — both manually and through the Moodle interface.  
Plugins extend Moodle’s core functionality and can add new activity types, themes, authentication methods, reports, and more.

---

## ⚠️ 2. Preliminary Considerations

Before installing a plugin:

| **Check** | **Description** |
|------------|----------------|
| Moodle version compatibility | Ensure the plugin supports your current Moodle version. |
| Plugin origin | Only install plugins from [Moodle Plugins Directory](https://moodle.org/plugins) or trusted developers. |
| Backup | Always back up your site and database before installation. |
| Test environment | Preferably install first on a staging or development instance. |

---

## 🧩 3. Plugin Installation Methods

There are two primary ways to install Moodle plugins:

| **Method** | **Recommended For** | **Description** |
|-------------|---------------------|-----------------|
| Via Moodle web interface | Most administrators | Upload and install plugin ZIP directly through the dashboard. |
| Via manual file upload | Advanced users, CLI environments | Manually copy plugin files into the correct directory. |

---

## 🌐 4. Method 1 — Install via Moodle Interface

1. Log in as an **Administrator**.
2. Navigate to:  
   `Site administration → Plugins → Install plugins`
3. Choose one of the following:
   - **Upload a ZIP file**: Download the plugin ZIP from [moodle.org/plugins](https://moodle.org/plugins) and upload it here.  
   - **Install directly from Moodle plugins directory** (if enabled): Search and install directly from the official repository.
4. Moodle will automatically:
   - Validate the plugin compatibility.
   - Detect its intended installation path.
   - Display warnings or dependency checks.
5. Click **Install plugin from ZIP file** and follow the on-screen instructions.
6. Once uploaded, the plugin installation screen will appear — review and confirm installation.
7. Moodle will then run the upgrade script to apply necessary database changes.

---

## 🧰 5. Method 2 — Manual Plugin Installation (File Upload)

### 5.1 Locate the correct plugin directory

| **Plugin Type** | **Target Directory (inside Moodle root)** |
|------------------|------------------------------------------|
| Activity module | `/mod/` |
| Block | `/blocks/` |
| Authentication method | `/auth/` |
| Report | `/report/` |
| Theme | `/theme/` |
| Question type | `/question/type/` |
| Local plugin | `/local/` |

### 5.2 Upload plugin files
```bash
cd /var/www/moodle
sudo git clone https://github.com/example/pluginname.git ./local/pluginname
```

or, if installing from a ZIP file:
```bash
unzip pluginname.zip -d /var/www/moodle/local/
```

### 5.3 Set correct permissions
```bash
sudo chown -R www-data:www-data /var/www/moodle
sudo chmod -R 755 /var/www/moodle
```

### 5.4 Run the Moodle upgrade script
```bash
sudo -u www-data /usr/bin/php /var/www/moodle/admin/cli/upgrade.php
```

Follow the on-screen prompts to complete installation.

---

## 🔍 6. Verifying the Installation

After installing a plugin:

| **Step** | **Action** |
|-----------|------------|
| Verify plugin appears | `Site administration → Plugins → Plugins overview` |
| Test its functionality | Create a test activity or access the feature added by the plugin |
| Check for errors | Review logs in `Site administration → Reports → Logs` or `/var/log/apache2/error.log` |
| Clear caches | Run `php /var/www/moodle/admin/cli/purge_caches.php` if changes do not appear |

---

## 🔐 7. Security and Maintenance

| **Best Practice** | **Description** |
|--------------------|-----------------|
| Update regularly | Keep plugins up to date to patch vulnerabilities. |
| Remove unused plugins | Deactivate and delete obsolete or incompatible ones. |
| Review plugin code | Especially for third-party or custom plugins. |
| Monitor performance | Poorly coded plugins can impact site speed. |
| Restrict installation permissions | Only site administrators should install or update plugins. |

---

## 🧩 8. Updating Plugins

To update an existing plugin:

1. Check the plugin page on [Moodle.org](https://moodle.org/plugins) for a new version.  
2. Download and install as you would a new plugin (Moodle will detect an upgrade).  
3. Run the upgrade via:
   ```bash
   sudo -u www-data php /var/www/moodle/admin/cli/upgrade.php
   ```
4. Review change logs for potential configuration changes.

---

## 🧾 9. Troubleshooting

| **Issue** | **Possible Cause** | **Fix** |
|------------|--------------------|----------|
| “Plugin is defective or invalid structure” | Wrong directory path | Ensure plugin folder name matches the expected structure. |
| “Cannot install plugin” | Version mismatch | Check the required Moodle version in `version.php`. |
| “White screen after installation” | PHP error | Check Apache/PHP logs. |
| Plugin missing from admin panel | Caching issue | Purge caches and reload. |

---

## ⚙️ 10. Uninstalling a Plugin

1. Go to:  
   `Site administration → Plugins → Plugins overview`
2. Locate the plugin and click **Uninstall**.
3. Moodle will remove it from the system.
4. Optionally, remove remaining files manually:
   ```bash
   sudo rm -rf /var/www/moodle/local/pluginname
   ```
5. Run the CLI upgrade again to finalize database cleanup:
   ```bash
   sudo -u www-data php /var/www/moodle/admin/cli/upgrade.php
   ```

---

## 🧾 11. Verification Checklist

| ✅ | **Task** |
|----|-----------|
| ☐ Plugin installed and visible in overview |
| ☐ Tested and functioning correctly |
| ☐ No PHP or Apache errors detected |
| ☐ Caches cleared |
| ☐ Backup updated after installation |

---

## 📚 12. References

- [Official Moodle Plugin Installation Docs](https://docs.moodle.org/en/Installing_plugins)  
- [Moodle Plugins Directory](https://moodle.org/plugins)  
- [Moodle CLI Upgrade Tool](https://docs.moodle.org/en/Administration_via_command_line)

---

**End of Guide**


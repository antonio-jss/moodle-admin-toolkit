# 🎨 Moodle Theme Installation Guide

**File:** `docs/guides/installation_theme.md`  
**Purpose:** Provide a step-by-step guide for installing and configuring themes in Moodle.  
**Audience:** Moodle administrators and system managers.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 📋 1. Overview

This guide explains how to install, configure, and manage **themes** in Moodle.  
Themes determine the visual appearance of your Moodle site, including layout, color schemes, typography, and overall user experience.  

You can install themes from the [Moodle Plugins Directory](https://moodle.org/plugins/?q=type:theme) or create your own custom theme.

---

## ⚠️ 2. Pre-Installation Requirements

Before installing a new theme:

| **Check** | **Description** |
|------------|----------------|
| **Moodle version compatibility** | Ensure the theme is compatible with your Moodle version. |
| **Backup** | Back up both your Moodle files and database. |
| **Test environment** | Always install and test themes on a staging or development site first. |
| **Dependency** | Verify whether the theme depends on another base theme (e.g., Boost). |

---

## 🧩 3. Theme Installation Methods

| **Method** | **Recommended For** | **Description** |
|-------------|---------------------|-----------------|
| **Via Moodle interface (ZIP upload)** | Most administrators | Upload and install the theme directly through the Moodle web interface. |
| **Manual installation (FTP/CLI)** | Developers and advanced users | Copy theme files directly into the Moodle theme directory. |

---

## 🌐 4. Method 1 — Install via Moodle Web Interface

1. Log in as an **Administrator**.  
2. Go to:  
   `Site administration → Plugins → Install plugins`
3. Upload the theme ZIP file downloaded from [Moodle.org](https://moodle.org/plugins/?q=type:theme).  
4. Moodle automatically detects it as a theme and verifies compatibility.  
5. Confirm installation by clicking **Install plugin from ZIP file**.  
6. Follow on-screen steps to review settings and complete installation.  
7. When prompted, click **Upgrade Moodle database now** to apply the theme.

---

## 🧰 5. Method 2 — Manual Installation (File Upload)

### 5.1 Locate the Theme Directory
All themes must be placed inside the `/theme/` folder within your Moodle installation directory.

Example:
```bash
/var/www/moodle/theme/
```

### 5.2 Upload the Theme Files
Copy or extract the theme folder into `/theme/`.

Example using command line:
```bash
cd /var/www/moodle/theme
sudo unzip theme_mycustom.zip -d /var/www/moodle/theme/
```

### 5.3 Set Correct Permissions
```bash
sudo chown -R www-data:www-data /var/www/moodle/theme
sudo chmod -R 755 /var/www/moodle/theme
```

### 5.4 Run the Moodle Upgrade Script
```bash
sudo -u www-data php /var/www/moodle/admin/cli/upgrade.php
```
Follow the interactive prompts to confirm the theme installation.

---

## 🎛️ 6. Activating the Theme

1. Navigate to:  
   `Site administration → Appearance → Theme selector`
2. Click **Change theme** in the appropriate device category (Default, Mobile, Tablet, etc.).  
3. Select the newly installed theme from the list.  
4. Save your changes.

---

## 🧩 7. Configuring Theme Settings

After activating the theme, you can customize it by going to:  
`Site administration → Appearance → Themes → [Theme Name]`

Common configurable elements include:

| **Setting** | **Description** |
|--------------|----------------|
| **Logo and favicon** | Upload your institution’s branding elements. |
| **Color palette** | Adjust primary and accent colors. |
| **Custom CSS** | Add site-specific CSS rules for finer control. |
| **Layout and region settings** | Define block placement and layout width. |
| **Typography** | Choose default fonts and text sizes. |

---

## 🔍 8. Verifying Theme Installation

| **Step** | **Action** |
|-----------|------------|
| Verify theme appears in the Theme Selector | Check that the new theme is listed and selectable. |
| Preview the site | Confirm visual changes and layout display correctly. |
| Clear caches | Run the cache purge command if changes don’t appear:  
  ```bash
  sudo -u www-data php /var/www/moodle/admin/cli/purge_caches.php
  ``` 
| Check logs | Monitor for errors under `Site administration → Reports → Logs`. |

---

## 🧰 9. Updating a Theme

1. Download the latest version of the theme.  
2. Replace the existing theme folder with the new one under `/theme/`.  
   ```bash
   sudo rm -rf /var/www/moodle/theme/themename
   sudo unzip theme_updated.zip -d /var/www/moodle/theme/
   ```
3. Run the upgrade script:  
   ```bash
   sudo -u www-data php /var/www/moodle/admin/cli/upgrade.php
   ```
4. Clear caches and test site functionality.

---

## 🧾 10. Uninstalling a Theme

1. Switch to another theme first (e.g., Boost or Classic).  
2. Go to:  
   `Site administration → Plugins → Plugins overview`
3. Find the theme and click **Uninstall**.  
4. After uninstallation, manually delete theme files if necessary:
   ```bash
   sudo rm -rf /var/www/moodle/theme/themename
   ```
5. Run the CLI upgrade to clean up database entries:
   ```bash
   sudo -u www-data php /var/www/moodle/admin/cli/upgrade.php
   ```

---

## ⚙️ 11. Troubleshooting

| **Issue** | **Possible Cause** | **Solution** |
|------------|--------------------|---------------|
| Theme not visible in selector | Wrong folder name or structure | Folder name must match `version.php` inside the theme. |
| White screen or error after activation | Incompatible or broken theme | Revert to default Boost theme via CLI. |
| Styles not updating | Cache issue | Purge caches manually. |
| Missing images or layout | Incorrect file permissions | Set proper file ownership and permissions. |

---

## 🧾 12. Verification Checklist

| ✅ | **Task** |
|----|-----------|
| ☐ Theme installed successfully |
| ☐ Theme activated and applied to all devices |
| ☐ Custom settings configured |
| ☐ Site appearance verified and tested |
| ☐ Backup updated post-installation |

---

## 📚 13. References

- [Moodle Theme Installation Documentation](https://docs.moodle.org/en/Installing_a_new_theme)  
- [Moodle Plugin Directory – Themes](https://moodle.org/plugins/?q=type:theme)  
- [Moodle CLI Administration Tools](https://docs.moodle.org/en/Administration_via_command_line)

---

**End of Guide**


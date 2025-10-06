# ✅ Moodle Post-Plugin Installation Checklist

**File:** `docs/checklists/after_installation_plugin.md`  
**Purpose:** Ensure system integrity, functionality, and compatibility after installing a new Moodle plugin.  
**Audience:** Moodle Administrators and Site Managers  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 🧩 1. General Information

| Item | Details |
|------|----------|
| **Plugin Name** | {{plugin_name}} |
| **Version Installed** | {{plugin_version}} |
| **Type** | (e.g., activity, block, local, report, theme, auth, enrol, etc.) |
| **Installation Date** | {{installation_date}} |
| **Installed By** | {{administrator_name}} |
| **Source** | (Moodle.org / GitHub / Custom Development) |

---

## 🔍 2. Pre-Installation Verification (for reference)

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 2.1 | Verified plugin compatibility with Moodle version | ✅ / ⚠️ / ❌ | |
| 2.2 | Backed up database and Moodledata directory | ✅ / ⚠️ / ❌ | |
| 2.3 | Checked server requirements (PHP, extensions, permissions) | ✅ / ⚠️ / ❌ | |
| 2.4 | Verified plugin code with antivirus / code scanning | ✅ / ⚠️ / ❌ | |

---

## ⚙️ 3. Post-Installation Functional Validation

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 3.1 | Confirmed that plugin appears in **Site Administration → Plugins → Plugins overview** | ✅ / ⚠️ / ❌ | |
| 3.2 | Checked that plugin version matches expected version | ✅ / ⚠️ / ❌ | |
| 3.3 | Verified that no errors or warnings appear during installation | ✅ / ⚠️ / ❌ | |
| 3.4 | Confirmed that default settings are correctly loaded | ✅ / ⚠️ / ❌ | |
| 3.5 | Verified that plugin integrates properly in its intended location (e.g., course, block, admin) | ✅ / ⚠️ / ❌ | |
| 3.6 | Checked that permissions/capabilities (`moodle/`, `pluginname:`) are properly defined | ✅ / ⚠️ / ❌ | |
| 3.7 | Tested plugin’s main functionality using a test course and test user | ✅ / ⚠️ / ❌ | |
| 3.8 | Verified that plugin does not break navigation or layout | ✅ / ⚠️ / ❌ | |
| 3.9 | Checked that cron jobs or scheduled tasks (if any) run without errors | ✅ / ⚠️ / ❌ | |
| 3.10 | Verified that logs are created correctly for plugin activities | ✅ / ⚠️ / ❌ | |

---

## 🧾 4. Performance & Compatibility Checks

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 4.1 | Checked site performance (page load, database queries) after installation | ✅ / ⚠️ / ❌ | |
| 4.2 | Confirmed compatibility with current theme and layout | ✅ / ⚠️ / ❌ | |
| 4.3 | Verified integration with mobile app (if applicable) | ✅ / ⚠️ / ❌ | |
| 4.4 | Checked multilingual display support | ✅ / ⚠️ / ❌ | |
| 4.5 | Tested accessibility (WCAG compliance, screen readers, keyboard nav) | ✅ / ⚠️ / ❌ | |

---

## 🧰 5. Security & Maintenance

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 5.1 | Verified that plugin does not alter critical roles or permissions | ✅ / ⚠️ / ❌ | |
| 5.2 | Checked for insecure file permissions or directories | ✅ / ⚠️ / ❌ | |
| 5.3 | Confirmed that plugin settings are restricted to admins only | ✅ / ⚠️ / ❌ | |
| 5.4 | Verified that data stored by plugin follows GDPR/data-privacy guidelines | ✅ / ⚠️ / ❌ | |
| 5.5 | Documented plugin settings and configuration in internal wiki | ✅ / ⚠️ / ❌ | |

---

## 📦 6. Backup & Rollback

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 6.1 | Performed a new backup after successful installation | ✅ / ⚠️ / ❌ | |
| 6.2 | Documented plugin version and configuration snapshot | ✅ / ⚠️ / ❌ | |
| 6.3 | Verified that rollback procedure (uninstall or restore) is functional | ✅ / ⚠️ / ❌ | |

---

## 🧭 7. Final Approval

| Reviewer | Date | Signature/Initials |
|-----------|------|--------------------|
| Moodle Administrator | | |
| QA Reviewer | | |
| IT Manager | | |

---

## 🗒️ Notes & Observations

> (Use this section to document anomalies, issues, improvement suggestions, or links to related tickets.)

---

### ✅ Completion Status
- [ ] All steps reviewed and marked  
- [ ] Plugin configuration documented  
- [ ] Functional test passed  
- [ ] Final approval granted  

---

**End of Checklist**


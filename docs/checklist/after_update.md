# 🧭 Moodle Post-Update Checklist

**File:** `docs/checklists/after_update.md`  
**Purpose:** Verify site integrity, functionality, and compatibility after a Moodle **core update**, **plugin update**, or **theme update**.  
**Audience:** Moodle Administrators and IT Managers  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 🧩 1. General Information

| Item | Details |
|------|----------|
| **Moodle Version (After Update)** | {{moodle_version}} |
| **Previous Version** | {{previous_version}} |
| **Update Type** | ☐ Core ☐ Plugins ☐ Theme ☐ Language Packs |
| **Date of Update** | {{update_date}} |
| **Performed By** | {{administrator_name}} |
| **Update Source** | (Official package / Git pull / CLI upgrade / Web installer) |

---

## 🔍 2. Pre-Update Reference (for record keeping)

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 2.1 | Verified that full site backups (database + Moodledata + code) were taken | ✅ / ⚠️ / ❌ | |
| 2.2 | Reviewed compatibility of installed plugins and themes | ✅ / ⚠️ / ❌ | |
| 2.3 | Noted system settings and maintenance mode status | ✅ / ⚠️ / ❌ | |
| 2.4 | Recorded PHP, database, and OS version before update | ✅ / ⚠️ / ❌ | |

---

## ⚙️ 3. Immediate Post-Update Verification

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 3.1 | Confirmed that Moodle upgrade script completed successfully (no errors) | ✅ / ⚠️ / ❌ | |
| 3.2 | Verified that the site loads correctly (no maintenance lock) | ✅ / ⚠️ / ❌ | |
| 3.3 | Checked that the version number is correctly updated in **Site administration → Notifications** | ✅ / ⚠️ / ❌ | |
| 3.4 | Purged caches via **Site administration → Development → Purge all caches** | ✅ / ⚠️ / ❌ | |
| 3.5 | Verified that cron is running without errors | ✅ / ⚠️ / ❌ | |
| 3.6 | Checked that scheduled tasks execute normally | ✅ / ⚠️ / ❌ | |
| 3.7 | Confirmed that the upgrade did not disable any essential plugins | ✅ / ⚠️ / ❌ | |
| 3.8 | Verified that the default theme loads properly | ✅ / ⚠️ / ❌ | |
| 3.9 | Checked that users can log in and access their dashboards | ✅ / ⚠️ / ❌ | |

---

## 🧭 4. Functional Testing

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 4.1 | Tested navigation menus, links, and breadcrumbs | ✅ / ⚠️ / ❌ | |
| 4.2 | Checked course pages load correctly | ✅ / ⚠️ / ❌ | |
| 4.3 | Verified that activities (quiz, forum, assignment, etc.) open as expected | ✅ / ⚠️ / ❌ | |
| 4.4 | Tested file uploads and resource downloads | ✅ / ⚠️ / ❌ | |
| 4.5 | Checked email notifications (message output configuration) | ✅ / ⚠️ / ❌ | |
| 4.6 | Verified calendar, grades, and reports display correctly | ✅ / ⚠️ / ❌ | |
| 4.7 | Tested enrolment and unenrolment processes | ✅ / ⚠️ / ❌ | |
| 4.8 | Verified user roles and permissions remain unchanged | ✅ / ⚠️ / ❌ | |
| 4.9 | Confirmed that backup and restore functionality works | ✅ / ⚠️ / ❌ | |
| 4.10 | Checked custom CSS and JS still apply correctly | ✅ / ⚠️ / ❌ | |

---

## ⚡ 5. Performance and Compatibility

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 5.1 | Measured load times on homepage and course pages | ✅ / ⚠️ / ❌ | |
| 5.2 | Checked browser console for JS or CSS errors | ✅ / ⚠️ / ❌ | |
| 5.3 | Verified integration with third-party systems (LTI, SSO, SCORM, etc.) | ✅ / ⚠️ / ❌ | |
| 5.4 | Tested plugin compatibility post-update | ✅ / ⚠️ / ❌ | |
| 5.5 | Confirmed that no database errors appear in logs | ✅ / ⚠️ / ❌ | |

---

## 🧾 6. Security Validation

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 6.1 | Checked that config.php and moodledata permissions remain secure | ✅ / ⚠️ / ❌ | |
| 6.2 | Verified HTTPS configuration and SSL certificate | ✅ / ⚠️ / ❌ | |
| 6.3 | Ensured that debug mode is disabled in production | ✅ / ⚠️ / ❌ | |
| 6.4 | Checked for new security notifications in **Site administration → Notifications** | ✅ / ⚠️ / ❌ | |
| 6.5 | Verified that no user accounts were unintentionally modified | ✅ / ⚠️ / ❌ | |

---

## 🌍 7. Accessibility & Localization

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 7.1 | Verified language packs updated successfully | ✅ / ⚠️ / ❌ | |
| 7.2 | Checked multilingual content still displays correctly | ✅ / ⚠️ / ❌ | |
| 7.3 | Tested right-to-left (RTL) layout for applicable languages | ✅ / ⚠️ / ❌ | |
| 7.4 | Confirmed accessibility compliance (WCAG 2.1 AA) | ✅ / ⚠️ / ❌ | |

---

## 🧰 8. Backup & Documentation

| Step | Description | Status | Comments |
|------|--------------|--------|-----------|
| 8.1 | Performed a post-update backup of the system | ✅ / ⚠️ / ❌ | |
| 8.2 | Documented update process, results, and any issues | ✅ / ⚠️ / ❌ | |
| 8.3 | Archived logs for update session (CLI/Web upgrade output) | ✅ / ⚠️ / ❌ | |
| 8.4 | Updated internal version documentation / changelog | ✅ / ⚠️ / ❌ | |

---

## 🧾 9. Final Review & Approval

| Reviewer | Date | Signature/Initials |
|-----------|------|--------------------|
| Moodle Administrator | | |
| QA Reviewer | | |
| IT Manager | | |

---

## 🗒️ Notes & Observations

> (Record performance issues, plugin conflicts, or configuration adjustments made after update.)

---

### ✅ Completion Status
- [ ] All tests passed successfully  
- [ ] Functional and security validation completed  
- [ ] Documentation updated  
- [ ] Final approval granted  

---

**End of Checklist**


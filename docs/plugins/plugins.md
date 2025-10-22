# 🔌 Recommended Moodle Plugins Guide

**File:** `docs/plugins/plugins.md`  
**Purpose:** Provide a curated list of reliable, widely used, and well-supported Moodle plugins to extend functionality while maintaining stability and security.  
**Audience:** Moodle administrators and instructional designers.  
**Last Updated:** {{Insert Date}}  
**Author:** {{Your Name}}

---

## 🧭 1. Overview

This guide lists **recommended Moodle plugins** organized by category (administration, course management, communication, analytics, and design).  
Each plugin has been selected for its **compatibility**, **stability**, and **active maintenance** by the Moodle community.

Plugins can significantly improve user experience and automation but must be tested on a **staging environment** before installation on production.

---

## ⚙️ 2. Installation Reminder

Before installing any plugin:
1. Verify compatibility with your Moodle version at [https://moodle.org/plugins](https://moodle.org/plugins).
2. Always make a full **site backup**.
3. Test plugin functionality on a **staging instance**.
4. Review and configure plugin permissions after installation.

---

## 🧩 3. Recommended Plugins by Category

### 3.1 Administration and Management

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Configurable Reports** | [moodle.org/plugins/block_configurable_reports](https://moodle.org/plugins/block_configurable_reports) | Custom report generation for administrators. | Excellent for analytics and audits. |
| **Reengagement** | [moodle.org/plugins/mod_reengagement](https://moodle.org/plugins/mod_reengagement) | Automate reminders to users for course progress. | Supports conditional messaging. |
| **Course Dedication** | [moodle.org/plugins/block_dedication](https://moodle.org/plugins/block_dedication) | Estimates time students spend in courses. | Useful for compliance and engagement monitoring. |
| **IntelliBoard (external)** | [intelliboard.net](https://intelliboard.net) | Advanced analytics and dashboards. | Paid plugin but highly recommended for corporate use. |

---

### 3.2 Course Design and Usability

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Format Tiles** | [moodle.org/plugins/format_tiles](https://moodle.org/plugins/format_tiles) | Improves course layout with interactive tiles. | Enhances UX and navigation. |
| **Level Up!** | [moodle.org/plugins/block_xp](https://moodle.org/plugins/block_xp) | Adds gamification features with points and levels. | Boosts motivation and engagement. |
| **Checklist** | [moodle.org/plugins/mod_checklist](https://moodle.org/plugins/mod_checklist) | Allows students to track their own progress. | Great for self-paced courses. |
| **Attendance** | [moodle.org/plugins/mod_attendance](https://moodle.org/plugins/mod_attendance) | Records and tracks attendance. | Integrates with grading system. |

---

### 3.3 Communication and Collaboration

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Dialogue** | [moodle.org/plugins/mod_dialogue](https://moodle.org/plugins/mod_dialogue) | Facilitates private discussions between users. | Useful for mentoring and coaching. |
| **BigBlueButtonBN** | [moodle.org/plugins/mod_bigbluebuttonbn](https://moodle.org/plugins/mod_bigbluebuttonbn) | Integrates BigBlueButton for live virtual classes. | Includes recording and breakout rooms. |
| **Zoom Meeting** | [moodle.org/plugins/mod_zoom](https://moodle.org/plugins/mod_zoom) | Connects Moodle with Zoom. | Requires Zoom API credentials. |
| **Quickmail** | [moodle.org/plugins/block_quickmail](https://moodle.org/plugins/block_quickmail) | Simplifies bulk email communication with users. | Great for course-wide announcements. |

---

### 3.4 Assessment and Feedback

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Quizventure** | [moodle.org/plugins/mod_quizgame](https://moodle.org/plugins/mod_quizgame) | Turns quiz questions into an interactive game. | Engaging alternative to standard quizzes. |
| **Attendance** | [moodle.org/plugins/mod_attendance](https://moodle.org/plugins/mod_attendance) | Manage attendance and participation. | Works well with grading. |
| **PoodLL** | [moodle.org/plugins/filter_poodll](https://moodle.org/plugins/filter_poodll) | Enables rich media assignments (audio/video). | Ideal for language learning. |
| **Feedback Fruits (external)** | [feedbackfruits.com](https://feedbackfruits.com) | Suite for peer review and feedback. | Paid service, high-quality integration. |

---

### 3.5 Analytics and Reporting

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Analytics Graphs** | [moodle.org/plugins/block_analytics_graphs](https://moodle.org/plugins/block_analytics_graphs) | Displays performance graphs for students. | Easy to interpret visual data. |
| **Configurable Reports** | [moodle.org/plugins/block_configurable_reports](https://moodle.org/plugins/block_configurable_reports) | Create custom reports and dashboards. | Flexible and well-supported. |
| **Ad-hoc database queries** | [moodle.org/plugins/report_customsql](https://moodle.org/plugins/report_customsql) | Run SQL-based reports from within Moodle. | Requires admin-level access. |

---

### 3.6 Security and Authentication

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Auth Google OAuth2** | Built-in | Enables Google-based authentication. | Secure SSO integration. |
| **MFA (Multi-factor Authentication)** | [moodle.org/plugins/tool_mfa](https://moodle.org/plugins/tool_mfa) | Adds extra authentication layers. | Improves overall system security. |
| **IP Blocker** | [moodle.org/plugins/local_ipblocker](https://moodle.org/plugins/local_ipblocker) | Restricts access by IP address. | Useful for compliance or testing. |

---

### 3.7 Integration and Automation

| **Plugin Name** | **Directory Link** | **Purpose** | **Notes** |
|------------------|--------------------|--------------|------------|
| **Web Service Manager** | [moodle.org/plugins/local_wsmanager](https://moodle.org/plugins/local_wsmanager) | Manages and monitors Moodle’s web services. | Facilitates integration with third-party tools. |
| **Dataform** | [moodle.org/plugins/mod_dataform](https://moodle.org/plugins/mod_dataform) | Customizable data collection and display. | Good for workflows and documentation. |
| **Microsoft 365 Integration** | [moodle.org/plugins/local_o365](https://moodle.org/plugins/local_o365) | Connects Moodle with Microsoft 365 suite. | Enables OneDrive, Teams, and calendar sync. |

---

## 🔍 4. Plugin Selection Criteria

When adding new plugins, evaluate them based on the following:

| **Criterion** | **Description** |
|----------------|----------------|
| **Maintenance** | Check if the plugin is regularly updated. |
| **Compatibility** | Confirm compatibility with your Moodle version. |
| **Community Support** | Look for active discussion and reviews. |
| **Security** | Verify the plugin follows Moodle’s coding standards. |
| **Performance** | Avoid plugins that slow down page loading. |
| **Documentation** | Choose plugins with detailed guides and examples. |

---

## 🧪 5. Testing Plugins

Always follow this testing protocol before enabling a plugin on production:

1. Install on a **staging environment**.  
2. Check for errors in `Site administration → Notifications`.  
3. Enable debugging mode and monitor logs.  
4. Test user interactions in different roles (admin, teacher, student).  
5. Validate that performance metrics remain stable.

---

## 🛡️ 6. Maintenance and Updates

- Regularly review installed plugins in  
  `Site administration → Plugins → Plugins overview`.  
- Uninstall unused or outdated plugins.  
- Update only one plugin at a time and test after each update.  
- Keep a **plugin version log** in `/docs/plugins/installed_plugins_log.md`.

---

## 📚 7. References

- [Official Moodle Plugin Directory](https://moodle.org/plugins)  
- [Moodle Developer Documentation](https://moodledev.io/docs)  
- [Moodle Security Guidelines](https://docs.moodle.org/en/Security)  
- [Moodle Plugin Development Guide](https://moodledev.io/docs/apis/core/plugins)  

---

**End of Guide**


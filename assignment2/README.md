BASH ASSIGNMENT

Name : SRINIVAS DM

### 1. QUESTIONS ATTEMPTED
- q1_system_info.sh: System info tool with colorized ASCII UI.
- q2_file_manager.sh: Interactive menu-driven file manager.
- q3_log_analyzer.sh: Log analyzer with CSV report generation.
- q4_backup.sh: Backup script with compression and cleanup.
- q5_user_report.sh: User audit tool with HTML output.

### 2. HOW TO RUN EACH SCRIPT
All scripts have execution permissions:
$ chmod +x *.sh

- q1: ./q1_system_info.sh
- q2: ./q2_file_manager.sh
- q3: ./q3_log_analyzer.sh <logfile>
- q4: ./q4_backup.sh
- q5: sudo ./q5_user_report.sh

### 3. VISUAL PROOF OF EXECUTION (SCREENSHOTS)
[Note: Refer to the "Screenshots" folder or the end of this document]

- [SCREENSHOT_01: q1_system_info.sh output showing formatted UI]
- [SCREENSHOT_02: q2_file_manager.sh menu and file creation]
- [SCREENSHOT_03: q3_log_analyzer.sh terminal results and CSV file]
- [SCREENSHOT_04: q4_backup.sh execution and backup directory list]
- [SCREENSHOT_05: q5_user_report.sh terminal output and HTML view]

### 4. SAMPLE TEST CASES
- q1: Verified extraction of disk usage (df) and memory statistics.
- q3: Tested with server logs; correctly identified 403 security threats.
- q4: Confirmed script deletes the 6th oldest backup to keep only 5.
- q5: Successfully generated 'user_report.html' and identified UID 0 users.

### 5. CHALLENGES FACED
- Formatting: Aligning ASCII borders in q1 when variable lengths changed.
- Permissions: Handling /etc/shadow access for user reporting in q5.
- Logic: Implementing the rotation logic to maintain exactly 5 backups in q4.
- Data Parsing: Efficiently using 'awk' for CSV and HTML table generation.

================================================================
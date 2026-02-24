#!/bin/bash

# User Report Script
echo "=== USER STATISTICS ==="
echo "Total Users: $(wc -l < /etc/passwd)"
echo "System Users (UID < 1000): $(awk -F: '$3 < 1000 {print $1}' /etc/passwd | wc -l)"
echo "Regular Users (UID >= 1000): $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd | wc -l)"
echo "Current Logged In: $(who | wc -l)"
echo ""

#regular user details
echo "=== REGULAR USER DETAILS ==="
awk -F: '$3 >= 1000 {print ""$1", "$3", "$6", "$7}' /etc/passwd | column -t -s, -N "--------,---,--------------,-----" | column  -t -N "Username,UID,Home Directory,Shell" 
echo""

#security alerts
echo "=== SECURITY ALERTS ==="
echo "Users with root privileges (UID 0): $(awk -F: '$3 == 0 {print $1}' /etc/passwd | wc -l)"
awk -F: '$3 == 0 {print "  - "$1}' /etc/passwd

#inactive users never logged in
if [ ! -f /etc/passwd ]; then
    echo "Inactive Users (never logged in):"
    awk -F: '($3 >= 1000) && ($7 != "/sbin/nologin") {print "  - "$1}' /etc/passwd
fi

# save report to html file
REPORT_FILE="user_report.html"
{
    echo "<html><head><title>User Report</title></head><body>"
    echo "<h1>User Statistics</h1>"
    echo "<p>Total Users: $(wc -l < /etc/passwd)</p>"
    echo "<p>System Users (UID < 1000): $(awk -F: '$3 < 1000 {print $1}' /etc/passwd | wc -l)</p>"
    echo "<p>Regular Users (UID >= 1000): $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd | wc -l)</p>"
    echo "<p>Current Logged In: $(who | wc -l)</p>"
    echo "<h2>Regular User Details</h2>"
    echo "<table border='1'><tr><th>Username</th><th>UID</th><th>Home Directory</th><th>Shell</th></tr>"
    awk -F: '$3 >= 1000 {print "<tr><td>"$1"</td><td>"$3"</td><td>"$6"</td><td>"$7"</td></tr>"}' /etc/passwd
    echo "</table>"
    echo "<h2>Security Alerts</h2>"
    echo "<p>Users with root privileges (UID 0): $(awk -F: '$3 == 0 {print $1}' /etc/passwd | wc -l)</p>"
    echo "<ul>"
    awk -F: '$3 == 0 {print "<li>"$1"</li>"}' /etc/passwd
    echo "</ul>"
    if [ -f /etc/passwd ]; then
        echo "<p>Inactive Users (never logged in):</p><ul>"
        awk -F: '($3 >= 1000) && ($7 != "/sbin/nologin") {print "<li>"$1"</li>"}' /etc/passwd
        echo "</ul>"
    fi
    if [ -r /etc/shadow ]; then
        echo "<p>Users with no password set:</p><ul>"
        awk -F: '($2 == "" || $2 == "!!") && $3 >= 1000 {print "<li>"$1"</li>"}' /etc/shadow
        echo "</ul>"
    else
        echo "<p>Password status unavailable (no read access to /etc/shadow)</p>"
    fi
    echo "</body></html>"
} > "$REPORT_FILE"
echo "User report saved to $REPORT_FILE" 




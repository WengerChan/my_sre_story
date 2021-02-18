#!/bin/expect

spawn /opt/IBM/ITM/bin/itmcmd config -A rz
expect "Enter instance name"
send "{insname}\r"

expect "ITCAM Extended Agent for Oracle Database"
send "\r"

expect "Default Username:"
send "monitor\r"

expect "Enter Default Password:"
send "1*oracle\r"

expect "Oracle Home Directory:"
send "/u01/app/oracle/19.3.0"

expect "Oracle Instant Client Installation Directory:"
send "\r"

expect "Net Configuration Files Directories:"
send "\r"

expect "Is default dynamic listener configured:"
send "\r"

expect "Customized"
send "\r"
send "\r"

expect "Edit"
send "1\r"

# Database connection name
expect "character, and the minus character can be used"
send "{epmname}\r"

expect "Connection Type:"
send "\r"

expect "Hostname:"
send "{hostname}\r"

expect "Port:"
send "1522\r"

expect "Service Name:"
send "{servicename}\r"

expect "SID"
send "{sid}\r"

expect "Database Username:"
send "monitor\r"

expect "Enter Database password:"
send "1*oracle\r"

expect "Role:"
send "\r"

expect "including alert log file name"
send "\r"

expect "Oracle Alert Log File Charset:"
send "\r"

expect "Edit"
send "\r"

expect "Will this agent connect to a TEMS"
send "\r"

expect "Network Protocol"
send "\r"

expect "Network Protocol 2"
send "\r"

expect "TEMS Host Name for IPv4"
send "{monip}\r"

expect "PIPE Port Number"
send "\r"

expect "Enter name of KDC"
send "\r"

expect "Configure connection for a secondary TEMS"
send "\r"

expect "Enter Optional Primary Network Name or 0 for"
send "\r"

expect "Disable HTTP"
send "\r"
send "\r"

expect eof
exit
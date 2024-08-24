Overview

This project contains scripts for automating security audits and server hardening on Linux servers. The main components are:

security_audit_hardening.sh: A script for performing security audits and applying hardening measures.
config.sh: A configuration script to set up necessary configurations for the audit and hardening process.
README.md: This file, providing an overview and instructions for the project.
Features
User and Group Audits: Check for users with root privileges, passwordless users, and weak passwords.
File and Directory Permissions: Scan for world-writable permissions and SUID/SGID bits.
Service Audits: List and check running services, ensuring critical services are properly configured.
Firewall and Network Security: Verify firewall configurations and check for open ports and insecure network settings.
IP and Network Configuration: Identify public vs. private IPs and ensure sensitive services are protected.
Security Updates and Patching: Check for and report available updates and patches.
Log Monitoring: Monitor logs for suspicious activities.
Server Hardening: Implement SSH key-based authentication, disable IPv6 if not needed, and configure automatic updates.
Installation
Clone the Repository:

- git clone git@github.com:Sahilnalawade241/linux-security-audit-hardening.git
- cd linux-security-audit-hardening
Make Scripts Executable:

chmod +x config.sh
chmod +x security_audit_hardening.sh
Run the Configuration Script:

./config.sh
./security_audit_hardening.sh

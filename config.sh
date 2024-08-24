#!/bin/bash

# Configuration settings for the security audit and hardening script

# Path to the log file where audit results will be stored
LOG_FILE="/var/log/security_audit.log"

# List of users that should be excluded from password checks
EXCLUDED_USERS=("root" "admin")

# Allowed services to be running on the server
ALLOWED_SERVICES=("sshd" "nginx" "apache2")

# Critical services that need to be running
CRITICAL_SERVICES=("sshd" "iptables")

# Firewall rules to be applied
FIREWALL_RULES=(
    "-A INPUT -p tcp --dport 22 -j ACCEPT"
    "-A INPUT -p tcp --dport 80 -j ACCEPT"
    "-A INPUT -p tcp --dport 443 -j ACCEPT"
    "-A INPUT -j DROP"
)

# List of directories to check for world-writable permissions
DIRECTORIES_TO_CHECK=(
    "/tmp"
    "/var/tmp"
)

# Update interval for automatic updates (in days)
UPDATE_INTERVAL=7

# SSH settings
SSH_KEY_PATH="/etc/ssh/ssh_host_rsa_key"
DISABLE_PASSWORD_AUTH="yes"

# Disable IPv6 if not required
DISABLE_IPV6="no"

# Path to the GRUB password file (for securing the bootloader)
GRUB_PASSWORD_FILE="/etc/grub.d/40_custom"

# Email settings for alerts
ALERT_EMAIL="admin@example.com"

# Custom checks and configurations can be added below

# Function to print the configuration
print_config() {
    echo "Configuration settings:"
    echo "Log file: $LOG_FILE"
    echo "Excluded users: ${EXCLUDED_USERS[@]}"
    echo "Allowed services: ${ALLOWED_SERVICES[@]}"
    echo "Critical services: ${CRITICAL_SERVICES[@]}"
    echo "Firewall rules:"
    for rule in "${FIREWALL_RULES[@]}"; do
        echo "  $rule"
    done
    echo "Directories to check: ${DIRECTORIES_TO_CHECK[@]}"
    echo "Update interval: $UPDATE_INTERVAL days"
    echo "SSH key path: $SSH_KEY_PATH"
    echo "Disable password auth: $DISABLE_PASSWORD_AUTH"
    echo "Disable IPv6: $DISABLE_IPV6"
    echo "GRUB password file: $GRUB_PASSWORD_FILE"
    echo "Alert email: $ALERT_EMAIL"
}

# Call the print_config function if this script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    print_config
fi

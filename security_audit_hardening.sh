#!/bin/bash

# Script for Automating Security Audits and Server Hardening on Linux Servers

# Load configuration file
source ./config.sh

# Function Declarations
audit_users_and_groups() {
    echo "Auditing users and groups..."

    # List all users and groups
    echo "Users and Groups:"
    cat /etc/passwd
    cat /etc/group

    # Check for users with UID 0
    echo "Users with UID 0 (root privileges):"
    awk -F: '$3 == 0 {print $1}' /etc/passwd

    # Identify users without passwords
    echo "Users without passwords:"
    awk -F: '($2 == "" ) {print $1}' /etc/shadow

    # Identify users with weak passwords
    echo "Users with weak passwords:"
    # Add custom logic to identify weak passwords
}

audit_file_permissions() 
 { echo "Auditing file and directory permissions..."

    # Scan for world-writable files
    echo "World-writable files:"
    find / -type f -perm -o=w 2>/dev/null

    # Check SSH directory permissions
    echo "Checking SSH directory permissions..."
    for user in $(cut -f1 -d: /etc/passwd); do
        if [ -d "/home/$user/.ssh" ]; then
            ls -ld /home/$user/.ssh
            ls -l /home/$user/.ssh/
        fi
    done

    # Check for SUID/SGID bits
    echo "Files with SUID/SGID bits set:"
    find / -perm /6000 -type f 2>/dev/null
}
audit_services() {
     echo "Auditing running services..."

    # List all running services
    echo "Running services:"
    systemctl list-units --type=service --state=running

    # Check for unnecessary services
    # Add custom logic based on organization needs

    # Check that critical services are running
    echo "Checking critical services..."
    systemctl is-active sshd
    systemctl is-active iptables

    # Check for services on non-standard ports
    echo "Services listening on non-standard ports:"
    netstat -tuln | grep -v ":22\|:80\|:443"  # Example for filtering standard ports
}

audit_firewall() {
   echo "Auditing firewall and network security..."

    # Verify that a firewall is active
    echo "Firewall status:"
    ufw status || iptables -L

    # List open ports and associated services
    echo "Open ports and services:"
    netstat -tuln

    # Check for IP forwarding
    echo "IP forwarding status:"
    sysctl net.ipv4.ip_forward
}

audit_ip_configuration() {
     echo "Checking IP and network configurations..."

    # Identify public vs. private IPs
    echo "Public and Private IP Addresses:"
    ip -4 addr show | grep inet

    # Ensure sensitive services are not exposed on public IPs
    echo "Checking sensitive services on public IPs..."
    # Add custom logic to ensure SSH is not exposed on public IPs unless required
}

audit_security_updates() {
     echo "Checking for security updates..."

    # Check for available security updates
    echo "Available updates:"
    apt list --upgradable

    # Ensure automatic updates are configured
    echo "Checking automatic updates configuration..."
    grep -r "APT::Periodic::Unattended-Upgrade" /etc/apt/apt.conf.d/
}

monitor_logs() {
     echo "Monitoring logs for suspicious activity..."

    # Check for suspicious SSH logins
    echo "Suspicious SSH logins:"
    grep "Failed password" /var/log/auth.log
}

harden_server() {
     echo "Hardening the server..."

    # Implement SSH key-based authentication
    echo "Configuring SSH for key-based authentication..."
    # Add configuration steps here

    # Disable IPv6 if not required
    echo "Disabling IPv6..."
    sysctl -w net.ipv6.conf.all.disable_ipv6=1
    sysctl -w net.ipv6.conf.default.disable_ipv6=1

    # Secure the bootloader
    echo "Securing GRUB bootloader..."
    # Add steps to set a GRUB password

    # Firewall configuration
    echo "Configuring the firewall..."
    # Add recommended iptables rules here

    # Configure automatic updates
    echo "Configuring automatic updates..."
    # Enable unattended-upgrades
    apt-get install unattended-upgrades -y
    dpkg-reconfigure --priority=low unattended-upgrades
}

generate_report() {
      echo "Generating security audit and hardening report..."
    
    # Create a summary report
    echo "Security Audit and Hardening Report" > report.txt
    echo "----------------------------------" >> report.txt
    
    # Add results of each audit and hardening step
    echo "User and Group Audit:" >> report.txt
    # Append user and group audit results
    
    echo "File and Directory Permissions Audit:" >> report.txt
    # Append file permission audit results
    
    echo "Service Audit:" >> report.txt
    # Append service audit results
    
    # Add other sections similarly
    
    # Optionally, send email alerts if critical issues are found
    # mail -s "Security Alert" admin@example.com < report.txt
}

# Main Execution Flow
audit_users_and_groups
audit_file_permissions
audit_services
audit_firewall
audit_ip_configuration
audit_security_updates
monitor_logs
harden_server
generate_report

# Vulnerability Scanner Mini Project
# Educational use only

import socket
import platform
import subprocess
from datetime import datetime

# Banner
print("=" * 50)
print(" SIMPLE VULNERABILITY SCANNER ")
print("=" * 50)

# Get target
target = input("Enter target IP or website: ")

# Common ports to scan
ports = [20, 21, 22, 23, 25, 53, 80, 110, 135, 139, 143, 443, 445, 8080]

print(f"\nScanning Target: {target}")
print(f"Time Started: {datetime.now()}")
print("-" * 50)

open_ports = []

# Port scanning
for port in ports:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(1)

    result = s.connect_ex((target, port))

    if result == 0:
        print(f"[OPEN] Port {port}")
        open_ports.append(port)

    s.close()

# OS Detection
print("\nChecking Operating System...")
os_name = platform.system()
print("Operating System:", os_name)

# Simple vulnerability checks
print("\nChecking for common vulnerabilities...")

if 21 in open_ports:
    print("Warning: FTP Port 21 is open (can be insecure)")

if 23 in open_ports:
    print("Warning: Telnet Port 23 is open (not secure)")

if 80 in open_ports:
    print("HTTP Port 80 open (website may not use encryption)")

if 445 in open_ports:
    print("SMB Port 445 open (possible file-sharing risk)")

# Generate report
report = open("vulnerability_report.txt", "w")

report.write("VULNERABILITY SCAN REPORT\n")
report.write("=" * 40 + "\n")
report.write(f"Target: {target}\n")
report.write(f"Scan Time: {datetime.now()}\n\n")

report.write("Open Ports:\n")
for port in open_ports:
    report.write(f"Port {port} is OPEN\n")

report.write("\nBasic Vulnerability Findings:\n")

if 21 in open_ports:
    report.write("- FTP Port 21 open\n")

if 23 in open_ports:
    report.write("- Telnet Port 23 open\n")

if 80 in open_ports:
    report.write("- HTTP Port 80 open\n")

if 445 in open_ports:
    report.write("- SMB Port 445 open\n")

report.close()

print("\nScan Completed!")
print("Report saved as vulnerability_report.txt")
print("=" * 50)

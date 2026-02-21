#!/bin/bash

TARGET=$1
#echo $TARGET
if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target_ip>"
    exit 1
fi

echo "[*] HTB Meow Auto-Exploit - Target : $TARGET"
echo "[*] Checking the connectivity to the target..."
ping -c 1 $TARGET > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "[-] Target $TARGET is not reachable. Please check the IP address and try again."
    exit 1
fi
echo "[+] Target $TARGET is reachable. Proceeding with the exploit..."
echo "[*] Running nmap to enumerate open ports and services..."
nmap -sC -sV -oN nmap_meow.txt $TARGET
echo "[*] Analyzing nmap results..."
if grep -q "23/tcp open" nmap_meow.txt; then
    echo "[+] Port 23 (Telnet) is open. Attempting to connect..."
    # Here you would add the code to attempt to exploit the Telnet service
else
    echo "[-] Port 23 (Telnet) is not open. The target may not be vulnerable or may have a different attack vector."
fi
echo "[*] Exploit script completed. Please review the nmap results and proceed with manual analysis for further exploitation steps."    
 telnet $TARGET
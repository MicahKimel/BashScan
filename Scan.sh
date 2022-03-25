#!/bin/bash
# A simple script
echo Start Scan $1 $2
echo ------------------------------------------------

sudo nmap -Pn -p- -sC -sV -v -oA $2/ports $1
sudo nmap -sU -sC -sV -oA $2/udp $1 --top-ports 100 -T4
sudo nmap -v --script=vuln -oA $2/vuln $1
gobuster dir -w ~/SecLists/Discovery/Web-Content/raft-medium-words.txt -o $2/dir -u $1 &
gobuster vhost -w ~/SecLists/Discovery/DNS/subdomains-top1million-110000.txt -o $2/vhost -u $1

echo ------------------------------------------------

#!/bin/bash
# A simple script
# To use simply call
# bash ./Scan.sh ipadd outputfolder
echo ------------------------------------------------
echo Start Scan on $1 ip output into $2
echo ------------------------------------------------

sudo nmap -Pn -p- -sC -sV -v --min-rate=400 --min-parallelism=100 -oA $2/ports $1
sudo nmap -sU -sC -sV -oA $2/udp $1 --top-ports 100 -T4 &
sudo nmap -v --script=vuln --min-rate=400 --min-parallelism=40 -oA $2/vuln $1 &
gobuster dir -w ~/SecLists/Discovery/Web-Content/raft-medium-words.txt -o $2/dir -u $1 &
gobuster vhost -w ~/SecLists/Discovery/DNS/subdomains-top1million-110000.txt -o $2/vhost -u $1

echo ------------------------------------------------

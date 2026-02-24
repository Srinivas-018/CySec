#!/bin/bash

#ANSI colors
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
RED='\e[1;31m'
YELLOW='\e[1;33m'
RESET='\e[0m'

#symbols for box drawing
TOP_LEFT='\u2554'
TOP_RIGHT='\u2557'
BOTTOM_LEFT='\u255a'
BOTTOM_RIGHT='\u255d'
VERTICAL='\u2551'

#commands
username=$(whoami)
hostname=$(hostname)
datetime=$(date +"%Y-%m-%d %H:%M:%S")
os=$(uname -o)
current_dir=$(pwd)
home_dir=$HOME
users_online=$(who | wc -l)
uptime=$(uptime -p)
disk_usage=$(df -h / | awk 'NR==2 {print $5}')
memory_usage=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')

#display system information
echo -e "${BLUE}${TOP_LEFT}$(printf '%.0s\u2550' {1..45})${TOP_RIGHT} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET}       ${YELLOW}SYSTEM INFORMATION DISPLAY${RESET}            ${BLUE}${VERTICAL}${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Username     :${RESET} ${RED}$username${RESET}                          ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Hostname     :${RESET} ${RED}$hostname${RESET}                         ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Date & Time  :${RESET} ${RED}$datetime${RESET}          ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}OS           :${RESET} ${RED}$os${RESET}                    ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Current Dir  :${RESET} ${RED}$current_dir${RESET}  ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Home Dir     :${RESET} ${RED}$home_dir${RESET}                    ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Users Online :${RESET} ${RED}$users_online${RESET}                            ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Uptime       :${RESET} ${RED}$uptime${RESET}       ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Disk Usage   :${RESET} ${RED}$disk_usage${RESET}                          ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${VERTICAL}${RESET} ${MAGENTA}Memory Usage :${RESET} ${RED}$memory_usage${RESET}                  ${BLUE}${VERTICAL} ${RESET}"
echo -e "${BLUE}${BOTTOM_LEFT}$(printf '%.0s\u2550' {1..45})${BOTTOM_RIGHT}${RESET}"

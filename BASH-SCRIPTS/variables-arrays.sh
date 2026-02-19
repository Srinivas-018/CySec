#variable assignments
TARGET="172.168.116.88"
PORT=80
#ping $TARGET
#command substitution
current_ip=$(hostname -I|awk '{print $1}')

#array assignment
PORTS=( 21 22 23 25 80 443 3306 3389 8080)

TARGETS=("172.168.116.88" "192.168.190.130")

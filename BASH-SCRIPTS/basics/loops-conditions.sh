#!/bin/bash

#for loop

for i in {1..255}; do
    echo $i
    ping -c 1 172.168.116.$i &>/dev/null && echo "172.168.116.$i is up"
done
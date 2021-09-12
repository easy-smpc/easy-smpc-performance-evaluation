#!/usr/bin/env bash
# Add easysmpc as localhost ip
echo "127.0.0.1 easysmpc.org" >> /etc/hosts 
# create domain and users detached
/root/createEnv.sh &
# Start james
/root/run_james.sh
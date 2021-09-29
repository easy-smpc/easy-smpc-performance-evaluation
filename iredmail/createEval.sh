#!/bin/bash
# Sleep
echo  "Sleep" 
sleep 5
#Set delay in network traffic
tc qdisc add dev lo root netem delay $(($TC_DELAY_MS/2))"ms"
# Create users
echo "Create users"
/opt/iredmail/bin/create_user easy0@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy1@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy2@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy3@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy4@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy5@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy6@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy7@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy8@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy9@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy10@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy11@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy12@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy13@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy14@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy15@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy16@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy17@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy18@easysmpc.org 12345 0
/opt/iredmail/bin/create_user easy19@easysmpc.org 12345 0

# Start evaluation
echo "Start evaluation"
cd /root/easy-smpc
/opt/jdk-14.0.2/bin/java -Dlog4j.configurationFile=org/bihealth/mi/easysmpc/nogui/log4j2.xml -jar easysmpc.eval.jar

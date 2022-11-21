#!/bin/bash
# Wait for it 
/root/wait-for-it.sh eb-service:8080 --timeout=30 --strict -- echo "service is up"
/root/wait-for-it.sh eb-keycloak:8080 --timeout=30 --strict -- echo "keylcloak is up"

#Set delay in network traffic
echo "Set network delay to $TC_DELAY_MS/2))ms"
tc qdisc add dev lo root netem delay $(($TC_DELAY_MS/2))"ms"

# Start evaluation
echo "Start evaluation"
cd /root/easy-smpc
java -Dlog4j2.configurationFile=org/bihealth/mi/easysmpc/performanceevaluation/log4j2.xml -jar easy-smpc-performance-evaluation-1.0.jar
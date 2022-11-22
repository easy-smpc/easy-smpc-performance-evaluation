#!/bin/bash -e

# Wait for it 
/home/spring/wait-for-it.sh eb-postgresql:5432 --timeout=30 --strict -- echo "db is up"

# Execute
java -jar easy-backend.jar --spring.config.location=application.yml
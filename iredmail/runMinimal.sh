#!/bin/bash 
sudo docker run \
	--rm \
	--name iredmail \
	--cap-add=NET_ADMIN \
	-d \
	--env TC_DELAY_MS=40 \
	ieasy:0.1

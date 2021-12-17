#!/bin/bash 
rm -f /target/easy-smpc-performance-evaluation-1.0.jar
cp ../target/easy-smpc-performance-evaluation-1.0.jar .
sudo docker build \
	-t easy-smpc-evaluation:1.0 \
	.

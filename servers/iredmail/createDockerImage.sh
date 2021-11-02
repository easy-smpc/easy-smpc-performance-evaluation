#!/bin/bash 
cp ../../target/easy-smpc-evaluation.jar .
sudo docker build \
	-t easy-smpc-evaluation:1.0 \
	.

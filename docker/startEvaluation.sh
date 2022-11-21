REMOVE?
#!/bin/bash 
sudo docker run \
	--rm \
	--name easy-eval \
	--cap-add=NET_ADMIN \
	-d \
	--env TC_DELAY_MS=30 \
	easy-smpc-evaluation:1.0

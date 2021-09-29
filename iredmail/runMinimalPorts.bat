docker run ^
    --rm ^
    --name iredmail ^
    --cap-add=NET_ADMIN ^
    -p 80:80 ^
    -p 443:443 ^
    -p 110:110 ^
    -p 995:995 ^
    -p 143:143 ^
    -p 993:993 ^
    -p 25:25 ^
    -p 465:465 ^
    -p 587:587 ^
    --env TC_DELAY_MS=40 ^
    ieasy:0.1
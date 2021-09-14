#!/bin/bash 
sudo docker run \
    --rm \
    --name iredmail \
    --env-file iredmail-docker.conf \
    --add-host=easysmpc.org:127.0.0.1 \
    --hostname mail.mydomain.com \
    -p 80:80 \
    -p 443:443 \
    -p 110:110 \
    -p 995:995 \
    -p 143:143 \
    -p 993:993 \
    -p 25:25 \
    -p 465:465 \
    -p 587:587 \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/backup-mysql:/var/vmail/backup/mysql \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/mailboxes:/var/vmail/vmail1 \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/mlmmj:/var/vmail/mlmmj \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/mlmmj-archive:/var/vmail/mlmmj-archive \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/imapsieve_copy:/var/vmail/imapsieve_copy \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/custom:/opt/iredmail/custom \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/ssl:/opt/iredmail/ssl \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/mysql:/var/lib/mysql \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/clamav:/var/lib/clamav \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/sa_rules:/var/lib/spamassassin \
    -v /home/felixw/git/easy-smpc-performance-evaluation/data/postfix_queue:/var/spool/postfix \
    iredmail/mariadb:stable


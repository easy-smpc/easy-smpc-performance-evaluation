docker run ^
    # --rm ^
    --name iredmail ^
    --env-file iredmail-docker.conf ^
	--add-host=easysmpc.org:127.0.0.1 ^
    --hostname easysmpc.org ^
    -p 80:80 ^
    -p 443:443 ^
    -p 110:110 ^
    -p 995:995 ^
    -p 143:143 ^
    -p 993:993 ^
    -p 25:25 ^
    -p 465:465 ^
    -p 587:587 ^
    -v iredmail_backup-mysql:/var/vmail/backup/mysql ^
    -v iredmail_mailboxes:/var/vmail/vmail1 ^
    -v iredmail_mlmmj:/var/vmail/mlmmj ^
    -v iredmail_mlmmj_archive:/var/vmail/mlmmj-archive ^
    -v iredmail_imapsieve_copy:/var/vmail/imapsieve_copy ^
    -v iredmail_custom:/opt/iredmail/custom ^
    -v iredmail_ssl:/opt/iredmail/ssl ^
    -v iredmail_mysql:/var/lib/mysql ^
    -v iredmail_clamav:/var/lib/clamav ^
    -v iredmail_sa_rules:/var/lib/spamassassin ^
    -v iredmail_postfix_queue:/var/spool/postfix ^
    iredmail/mariadb:stable
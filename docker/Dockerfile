FROM iredmail/mariadb:stable
# Create volumes
# Set environment var
ENV HOSTNAME=mail.easysmpc.org
ENV FIRST_MAIL_DOMAIN=easysmpc.org
ENV FIRST_MAIL_DOMAIN_ADMIN_PASSWORD=12345
ENV MLMMJADMIN_API_TOKEN=12345
ENV ROUNDCUBE_DES_KEY=12345
ENV USE_IREDAPD=NO
ENV USE_ANTISPAM=NO
ENV USE_FAIL2BAN=NO
ENV USE_ROUNDCUBE=NO
ENV USE_IREDADMIN=NO
ENV TC_DELAY_MS=40

# Install
RUN apt-get update && apt-get install -y dos2unix

# Get JDK
WORKDIR /opt
ADD https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz .
RUN ["tar", "-xf", "openjdk-14.0.2_linux-x64_bin.tar.gz"]

# Copy files
WORKDIR /root
COPY easy-smpc-performance-evaluation-1.0.jar ./easy-smpc/easy-smpc-performance-evaluation-1.0.jar
COPY createEval.sh .
RUN dos2unix createEval.sh
COPY dovecot.conf /etc/dovecot
COPY main.cf /etc/postfix
COPY master.cf /etc/postfix
COPY ./ssl/* /opt/iredmail/ssl/
COPY entrypoint.sh /
RUN dos2unix /entrypoint.sh

# EXPOSE ports
EXPOSE 80
EXPOSE 443
EXPOSE 110
EXPOSE 995
EXPOSE 143
EXPOSE 993
EXPOSE 25
EXPOSE 465
EXPOSE 587
# Define entrypoint and cmd
# CMD /root/createEval.sh

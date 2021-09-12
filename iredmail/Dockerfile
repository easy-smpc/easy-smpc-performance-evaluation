FROM apache/james:memory-3.6.0
# Get JDK
WORKDIR /opt
ADD https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz .
RUN ["tar", "-xf", "openjdk-14.0.2_linux-x64_bin.tar.gz"]
# Copy files
WORKDIR /root
RUN ["mkdir", "./easy-smpc"]
VOLUME ["/root/easy-smpc"]
COPY smtpserver.xml conf
COPY createEnv.sh .
COPY startup.sh .
COPY easysmpc.eval.jar ./easy-smpc
# Expose ports
EXPOSE 25
EXPOSE 143
# Define entrypoint and cmd
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/root/startup.sh"]

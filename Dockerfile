FROM apache/james:memory-3.6.0
COPY smtpserver.xml /root/conf
COPY createEnv.sh /root
COPY startup.sh /root
EXPOSE 25
EXPOSE 143
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/root/startup.sh"]
# Volume!
FROM blalor/centos:latest

EXPOSE 14000
ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

RUN \
    yum localinstall -y https://blalor-yum.s3.amazonaws.com/el6/blalor-yum-1.0-1.noarch.rpm && \
    yum install -y python-supervisor socat && \
    yum clean all && \
    mkdir -p /etc/supervisor.d /var/log/supervisor

ADD config/supervisord.conf /etc/supervisord.conf
ADD config/program-socat-shell.conf /etc/supervisor.d/


FROM blalor/centos:latest
MAINTAINER Brian Lalor <blalor@bravo5.org>

EXPOSE 22
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

ADD src/ /tmp/src/
RUN /tmp/src/setup.sh

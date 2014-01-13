#!/bin/bash

set -e
set -x

cd /tmp/src

yum localinstall -y https://blalor-yum.s3.amazonaws.com/el6/blalor-yum-1.0-1.noarch.rpm

yum install -y python-supervisor openssh-server passwd rootfiles cronie

## === SUPERVISORD CONFIG

mkdir -p /etc/supervisor.d /var/log/supervisor

mv config/supervisord.conf /etc/supervisord.conf
mv config/program-*.conf /etc/supervisor.d/

## === SSH CONFIG

## @todo generate key and configure key-only auth
## sed -i -e 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

## allow root to log in
sed -i -e 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

echo d0ck3r | passwd --stdin root

## http://gaijin-nippon.blogspot.com/2013/07/audit-on-lxc-host.html
sed -i -e '/pam_login/d' /etc/pam.d/sshd
sed -i -e '/pam_login/d' /etc/pam.d/login

## prevent sshd from daemonizing
echo 'OPTIONS="-D"' >> /etc/sysconfig/sshd

## === CROND CONFIG

## prevent crond from daemonizing, send logs to syslog, no mail
echo 'CRONDARGS="-m off -s -n"' >> /etc/sysconfig/crond

## relax pam to let cron run
## http://lists.freedesktop.org/archives/systemd-devel/2013-May/010944.html
sed -i -E -e 's/^(.*pam_loginuid.so)$/#\1/g' /etc/pam.d/crond

## === RSYSLOGD CONFIG

## prevent rsyslogd from daemonizing
sed -i -e 's#^SYSLOGD_OPTIONS.*#SYSLOGD_OPTIONS="-c 5 -n"#' /etc/sysconfig/rsyslog

## === CLEANUP
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src

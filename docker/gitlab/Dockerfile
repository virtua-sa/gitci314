FROM resin/rpi-raspbian:stretch

RUN     apt-get update \
    &&  apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            openssh-server \
            postfix \
    &&  curl -sS https://packages.gitlab.com/gpg.key | apt-key add - \
    &&  curl -sS https://packages.gitlab.com/install/repositories/gitlab/raspberry-pi2/script.deb.sh | os=raspbian dist=jessie bash - \
    &&  apt-get update
RUN     apt-get install -y \
            gitlab-ce \
    &&  gitlab-ctl reconfigure

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]
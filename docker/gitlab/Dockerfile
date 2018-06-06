FROM resin/rpi-raspbian:stretch
MAINTAINER Virtua SA <info@virtua.ch>

# Install required packages and add Gitlab repositories
RUN     apt-get update \
    &&  apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            openssh-server \
            postfix \
            wget

# Resolve error: TERM environment variable not set.
ENV TERM xterm

# Define version of Gitlab to install
# See: https://packages.gitlab.com/gitlab/raspberry-pi2
ARG GITLAB_VERSION=10.8.3-ce.0

# Copy assets
COPY assets/ /assets/

# Install Gitlab
RUN     /assets/setup

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

# Wrapper to handle signal, trigger runit and reconfigure GitLab
CMD ["/assets/wrapper"]

# Run healthcheck tests
HEALTHCHECK --interval=60s --timeout=30s --retries=5 \
CMD /opt/gitlab/bin/gitlab-healthcheck --fail
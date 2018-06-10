FROM resin/rpi-raspbian:stretch
MAINTAINER Virtua SA <info@virtua.ch>

# Install required packages and add Gitlab repositories
RUN     apt-get update \
    &&  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
            apt-transport-https \
            ca-certificates \
            curl \
            git \
            gnupg \
            wget \
    &&  apt-get clean -y && apt-get clean -y && apt-get autoclean -y && rm -r /var/lib/apt/lists/*

# Install gitlab-runner
RUN     curl -sSL https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm \
            > /usr/local/bin/gitlab-runner \
    &&  chmod +x /usr/local/bin/gitlab-runner \
    &&  useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash \
    &&  gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner \
    &&  gitlab-runner --version \
    &&  curl -sSL https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-Linux-armhf \
            > /usr/local/bin/docker-machine \
    &&  chmod +x /usr/local/bin/docker-machine \
    &&  docker-machine --version

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner", "/var/run/docker.sock"]

CMD ["run"]
ENTRYPOINT ["gitlab-runner"]
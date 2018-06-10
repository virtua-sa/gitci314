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

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates wget apt-transport-https vim nano tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG DOCKER_MACHINE_VERSION
ARG DUMB_INIT_VERSION

COPY gitlab-runner_amd64.deb /tmp/
COPY checksums /tmp/
RUN curl -sSL https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm \
            > /usr/local/bin/gitlab-runner \
    apt-get update &&  \
    apt-get -f install -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm /tmp/gitlab-runner_amd64.deb && \
    gitlab-runner --version && \
    mkdir -p /etc/gitlab-runner/certs && \
    chmod -R 700 /etc/gitlab-runner && \
    wget -q https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-Linux-x86_64 -O /usr/bin/docker-machine && \
    chmod +x /usr/bin/docker-machine && \
    docker-machine --version && \
    wget -q https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 -O /usr/bin/dumb-init && \
    chmod +x /usr/bin/dumb-init && \
    dumb-init --version && \
    sha256sum --check --strict /tmp/checksums

COPY entrypoint /
RUN chmod +x /entrypoint

VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
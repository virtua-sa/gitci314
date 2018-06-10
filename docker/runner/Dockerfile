FROM resin/rpi-raspbian:stretch
MAINTAINER Virtua SA <info@virtua.ch>

RUN     curl -sSL https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm \
            > /usr/local/bin/gitlab-runner \
    &&  chmod +x /usr/local/bin/gitlab-runner \
    &&  curl -sSL https://get.docker.com/ | sh \
    &&  useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash \
    &&  gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

VOLUME ["/home/gitlab-runner", "/var/run/docker.sock"]

CMD ["run"]
ENTRYPOINT ["gitlab-runner"]
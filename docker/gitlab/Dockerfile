FROM resin/rpi-raspbian:stretch
MAINTAINER Virtua SA <info@virtua.ch>

# Resolve error: TERM environment variable not set.
ENV TERM xterm

# Install required packages and add Gitlab repositories
RUN     apt-get update \
    &&  apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            openssh-server \
            postfix \
    &&  curl -sSL https://packages.gitlab.com/gpg.key | apt-key add - \
    &&  curl -sSL https://packages.gitlab.com/install/repositories/gitlab/raspberry-pi2/script.deb.sh | os=raspbian dist=jessie bash - \
    &&  apt-get update

# Install Gitlab CE
RUN     EXTERNAL_URL="http://localhost" apt-get install -y gitlab-ce

# Copy assets
COPY assets/ /assets/

# Patch Omnibus Gitlab package and force it to use shipped gitlab.rb configuration file
RUN     rm -f /etc/gitlab/gitlab.rb \
    &&  sed -i "s/external_url 'GENERATED_EXTERNAL_URL'/# external_url 'GENERATED_EXTERNAL_URL'/" /opt/gitlab/etc/gitlab.rb.template \
    &&  sed -i "s/\/etc\/gitlab\/gitlab.rb/\/assets\/gitlab.rb/" /opt/gitlab/embedded/cookbooks/gitlab/recipes/show_config.rb \
    &&  sed -i "s/\/etc\/gitlab\/gitlab.rb/\/assets\/gitlab.rb/" /opt/gitlab/embedded/cookbooks/gitlab/recipes/config.rb
# Configure Gitlab for the first time
RUN     gitlab-ctl reconfigure

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

# Wrapper to handle signal, trigger runit and reconfigure GitLab
CMD ["/assets/wrapper"]

# Run healthcheck tests
HEALTHCHECK --interval=60s --timeout=30s --retries=5 \
CMD /opt/gitlab/bin/gitlab-healthcheck --fail
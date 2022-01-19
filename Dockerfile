ARG version
# Using latest release of Atlantis
FROM ghcr.io/runatlantis/atlantis:${version}

# Install required packages
RUN apk --update --no-cache add ca-certificates openssl openssh-client curl git jq nodejs npm

RUN \
  # Install latest infracost version
  curl -s -L https://github.com/infracost/infracost/releases/latest/download/infracost-linux-amd64.tar.gz | tar xz -C /tmp && \
  mv /tmp/infracost-linux-amd64 /usr/bin/infracost && \
  # Fetch the atlantis_diff.sh script that runs infracost
  curl -s -L -o /home/atlantis/infracost_atlantis_diff.sh https://raw.githubusercontent.com/infracost/infracost/master/scripts/ci/atlantis_diff.sh && \
  chmod +x /home/atlantis/infracost_atlantis_diff.sh && \
  ln -s /home/atlantis/infracost_atlantis_diff.sh /infracost_atlantis_diff.sh

# Install the latest compost version
RUN npm install -g @infracost/compost

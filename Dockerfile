# Bitbucket CI image based on: atlassian/default-image:2

FROM ubuntu:16.04

# Install base dependencies
RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        build-essential \
        wget \
        xvfb \
        curl \
        git \        
        ssh-client \
        zip \
        unzip \
        iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Install nvm with node and npm
ENV NODE_VERSION=12.18.4 \
    NVM_DIR=/root/.nvm \
    NVM_VERSION=0.36.0

RUN curl https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    # Install npm patches and latest yarn
    && npm install -g npm yarn \
    # smoke tests
    && node --version \
    && npm --version


# Set node path
ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules


# Default to UTF-8 file.encoding
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LANGUAGE=C.UTF-8

# Xvfb provide an in-memory X-session for tests that require a GUI
ENV DISPLAY=:99

# Set the path.
ENV PATH=$NVM_DIR:$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Create dirs and users
RUN mkdir -p /opt/atlassian/bitbucketci/agent/build \
    && sed -i '/[ -z \"PS1\" ] && return/a\\ncase $- in\n*i*) ;;\n*) return;;\nesac' /root/.bashrc \
    && useradd --create-home --shell /bin/bash --uid 1000 pipelines

WORKDIR /opt/atlassian/bitbucketci/agent/build
ENTRYPOINT /bin/bash
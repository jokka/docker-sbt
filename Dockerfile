# Dockerfile
FROM debian:jessie

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Add JDK 8
RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# Run updates and install deps
RUN apt-get update

RUN apt-get install -y -q --no-install-recommends \
    apt-utils \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    g++ \
    gcc \
    git \
    make \
    sudo \
    wget \
    pkg-config \
    libcairo2-dev libjpeg-dev libgif-dev \
    openjdk-8-jdk

# Run updates and install deps
RUN apt-get update
RUN apt-get install -y -q --no-install-recommends \
    python-pip \
    python-setuptools \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -y autoclean

RUN pip install awscli
RUN pip install https://github.com/google/closure-linter/zipball/master

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.9.0

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /app

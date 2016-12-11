FROM ubuntu:14.04

ENV BUILD_PACKAGES bash openssh-server git-core openssh-client curl build-essential openssl autoconf libc6-dev ncurses-dev automake libtool pkg-config software-properties-common python-software-properties libpq-dev postgresql-client-9.3
ENV RUBY_PACKAGES ruby2.3 ruby2.3-dev rake

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y $BUILD_PACKAGES && \
    apt-add-repository ppa:brightbox/ruby-ng -y && \
    apt-get update && \
    apt-get install -y $RUBY_PACKAGES && \
    rm -rf /var/cache/apt/*

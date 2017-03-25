FROM ubuntu:16.04
MAINTAINER Maciej Litwiniuk <maciej@litwiniuk.net>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential g++ flex bison gperf ruby perl \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev python libx11-dev libxext-dev git-core

# Install phantomjs manually: https://www.npmjs.com/package/phantomjs#using-phantomjs-from-disk
# ensuring it doesn't need to be installed when npm install phantomjs

RUN \
  cd /tmp && \
  git clone git://github.com/ariya/phantomjs.git && \
  cd phantomjs && \
  git checkout 2.1.1 && \
  git submodule init && \
  git submodule update && \
  python build.py

RUN cp /tmp/phantomjs/bin/phantomjs /usr/local/bin/

RUN rm -fr /tmp/phantomjs


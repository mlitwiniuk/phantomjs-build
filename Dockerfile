FROM ubuntu:16.04
MAINTAINER Maciej Litwiniuk <maciej@litwiniuk.net>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential g++ flex bison gperf ruby perl \
  libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
  libpng-dev libjpeg-dev python libx11-dev libxext-dev git-core

#ENV RUBY_DOWNLOAD_SHA256 df795f2f99860745a416092a4004b016ccf77e8b82dec956b120f18bdc71edce
#ADD https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz /tmp/

#RUN cd /tmp && \
    #echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.2.3.tar.gz" | sha256sum -c - && \
    #tar -xzf ruby-2.2.3.tar.gz && \
    #cd ruby-2.2.3 && \
    #./configure && \
    #make && \
    #make install && \
    #cd .. && \
    #rm -rf ruby-2.2.3 && \
    #rm -f ruby-2.2.3.tar.gz


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


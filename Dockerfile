FROM ubuntu:14.04
MAINTAINER Edwin van der Graaf <edwin@digitpaint.nl>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev git python-software-properties

ENV RUBY_DOWNLOAD_SHA256 df795f2f99860745a416092a4004b016ccf77e8b82dec956b120f18bdc71edce
ADD https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz /tmp/

RUN cd /tmp && \
    echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.2.3.tar.gz" | sha256sum -c - && \
    tar -xzf ruby-2.2.3.tar.gz && \
    cd ruby-2.2.3 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf ruby-2.2.3 && \
    rm -f ruby-2.2.3.tar.gz

 # Install dependencies for building phantomjs
RUN apt-get -y install g++ flex bison gperf  perl \
                       libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 \
                       libpng-dev libjpeg-dev python libx11-dev libxext-dev unzip

# Install phantomjs manually: https://www.npmjs.com/package/phantomjs#using-phantomjs-from-disk
# ensuring it doesn't need to be installed when npm install phantomjs
ENV PHANTOMJS_DOWNLOAD_SHA256 cc81249eaa059cc138414390cade9cb6509b9d6fa0df16f4f43de70b174b3bfe
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.0.0-source.zip /tmp/

RUN \
  cd /tmp && \
  echo "$PHANTOMJS_DOWNLOAD_SHA256 *phantomjs-2.0.0-source.zip" | sha256sum -c - && \
  unzip phantomjs-2.0.0-source.zip && \
  rm -f phantomjs-2.0.0-source.zip && \
  cd phantomjs-* && \
  ./build.sh --confirm && \
  cp bin/phantomjs /usr/local/bin/ && \
  cd /tmp && \
  rm -rf /tmp/phantomjs-*


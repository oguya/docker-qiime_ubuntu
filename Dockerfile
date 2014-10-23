# Qiime on ubuntu-14.04
#FROM ubuntu:14.04
FROM oguya/webbase:latest
MAINTAINER James Oguya <oguyajames@gmail.com>

# we use can vars
# http://jonathan.bergknoff.com/journal/building-good-docker-images
ENV HOSTNAME qiimey
ENV QIIME_HOME /opt/qiime
ENV QIIME_VERSION 1.8.0
ENV QIIME_PREFIX $QIIME_HOME/qiime_software/$QIIME_VERSION

# update cache, install pip
RUN apt-get -y update && apt-get -y upgrade

# install qiime system deps
RUN apt-get --force-yes -y install python-dev libncurses5-dev libssl-dev libzmq-dev libgsl0-dev openjdk-6-jdk libxml2 libxslt1.1 libxslt1-dev ant git subversion build-essential zlib1g-dev libpng12-dev libfreetype6-dev mpich2 libreadline-dev gfortran unzip libmysqlclient18 libmysqlclient-dev ghc sqlite3 libsqlite3-dev libc6-i386 libbz2-dev

# clone qiime setup repos
RUN git clone git://github.com/qiime/qiime-deploy.git $QIIME_HOME/qiime-deploy
RUN git clone git://github.com/qiime/qiime-deploy-conf.git $QIIME_HOME/qiime-deploy-conf

# install qime in $PREFIX dir
RUN python $QIIME_HOME/qiime-deploy/qiime-deploy.py $QIIME_PREFIX -f $QIIME_HOME/qiime-deploy-conf/qiime-$QIIME_VERSION/qiime.conf --force-remove-failed-dirs
RUN source $QIIME_HOME/qiime_software/$QIIME_VERSION
RUN source $QIIME_PREFIX/activate.sh

# do we need an entrypoint ? - not overridable
# https://docs.docker.com/reference/builder/#entrypoint
#ENTRYPOINT $CMD

# do we need to expose & forward any ports ? 80, 22 ??
# EXPOSE

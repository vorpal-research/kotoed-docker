FROM kopppcappp/archlinux-yaourt
MAINTAINER Mikhail Belyaev

RUN pacman -Syy
RUN pacman --noconfirm --needed -S postgresql
RUN sudo -u postgres initdb --locale en_US.UTF-8 -E UTF8 -D "/var/lib/postgres/data"

RUN sudo mkdir /run/postgresql
RUN sudo chown postgres:postgres /run/postgresql
RUN sudo -u postgres /usr/bin/postgresql-check-db-dir "/var/lib/postgres/data"
COPY start_postgresql.sh /usr/bin/start_postgresql.sh
RUN sudo chmod +s /usr/bin/start_postgresql.sh
RUN sudo chmod +x /usr/bin/start_postgresql.sh
RUN pacman --noconfirm --needed -S git
RUN pacman --noconfirm --needed -S mercurial
RUN sudo -u yaourt yaourt --noconfirm --needed -S jdk
RUN pacman --noconfirm --needed -S maven
RUN sudo -u yaourt yaourt --noconfirm --needed -S teamcity
COPY start_teamcity.sh /usr/bin/start_teamcity.sh
RUN sudo chmod +s /usr/bin/start_teamcity.sh
RUN sudo chmod +x /usr/bin/start_teamcity.sh
RUN mkdir kotoed && cd kotoed && hg clone https://bitbucket.org/vorpal-research/kotoed . && mvn dependency:resolve dependency:resolve-plugins
RUN rm -rf kotoed
COPY BuildServer.tar.gz /root/
RUN cd /root && tar xpvzf BuildServer.tar.gz

RUN pacman --noconfirm -S python-pip
RUN pip install buildbot[bundle]

RUN buildbot create-master -r /root/bb-master
RUN buildbot-worker create-worker /root/bb-worker localhost:9989 "kotoed-worker" "kotoed-password"

COPY master.cfg /root/bb-master
COPY 688b3917ff347813631c24e0ebdd3c67.json /root/bb-master
RUN mkdir /root/hg
RUN hg clone https://bitbucket.org/vorpal-research/buildbot-dynamic /root/hg/buildbot-dynamic

COPY start_buildbot.sh /usr/bin/start_buildbot.sh
RUN sudo chmod +s /usr/bin/start_buildbot.sh
RUN sudo chmod +x /usr/bin/start_buildbot.sh

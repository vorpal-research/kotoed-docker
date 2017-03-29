FROM kopppcappp/archlinux-yaourt
MAINTAINER Mikhail Belyaev

RUN pacman -Syy
RUN pacman --noconfirm --needed -S postgresql
RUN sudo -u postgres initdb --locale en_US.UTF-8 -E UTF8 -D "/var/lib/postgres/data"
RUN sudo systemctl enable postgresql
RUN sudo mkdir /run/postgresql
RUN sudo chown postgres:postgres /run/postgresql
RUN sudo -u postgres /usr/bin/postgresql-check-db-dir "/var/lib/postgres/data"
RUN sudo -u postgres /usr/bin/pg_ctl -s -D "/var/lib/postgres/data" start -w -t 120

#!/usr/bin/env bash

sudo -u postgres /usr/bin/pg_ctl -s -D "/var/lib/postgres/data" start -w -t 120

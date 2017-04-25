#!/usr/bin/env bash

sudo TEAMCITY_SERVER_MEM_OPTS="-Xms64m -Xmx128m" /opt/teamcity/bin/runAll.sh start

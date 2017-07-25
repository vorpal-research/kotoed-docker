#!/usr/bin/env bash

sudo PYTHONPATH=/root/hg/buildbot-dynamic buildbot start /root/bb-master
sudo buildbot-worker start /root/bb-worker

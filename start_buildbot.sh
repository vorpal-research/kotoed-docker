#!/usr/bin/env bash

sudo PYTHONPATH=/root/hg/buildbot-dynamic buildbot start /root/bb-master
sudo PYTHONPATH=/root/hg/buildbot-dynamic buildbot-worker start /root/bb-worker

#!/bin/sh

chown -R gitea:gitea /home/gitea/gitea/data
chown -R gitea:gitea /home/gitea/gitea/log
exec runuser -u gitea "$@"

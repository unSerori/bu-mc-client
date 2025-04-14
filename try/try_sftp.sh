#!/bin/bash

# sftpでの投稿

source ../.env

sftp -oport="2222" -b try_sftp.bat -i ../key/key -o UserKnownHostsFile=../key/known_hosts mc-user@${SERVER_IP}

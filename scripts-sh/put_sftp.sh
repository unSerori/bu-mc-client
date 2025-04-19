#!/bin/bash

# sftpでの投稿

# args
bu_sv_port=$1
server_ip=$2
save_dir_name_sv_world=$3
compress_file_name=$4

sftp -oport="$bu_sv_port" -i ../key/key -o UserKnownHostsFile=../key/known_hosts mc-user@${server_ip} <<EOF
cd saves
mkdir "$save_dir_name_sv_world"
cd "$save_dir_name_sv_world"
put "${compress_file_name}"
bye
EOF

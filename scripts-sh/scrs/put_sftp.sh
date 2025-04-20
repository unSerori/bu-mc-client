#!/bin/bash

# sftpでの投稿

# Parameters
# $1 bu_sv_port: 数字
#   接続先ポート
# $2 server_ip: 文字列
#   接続先IP
# $3 save_dir_name_sv_world: 文字列
#   アップロード先にどこのサーバのなんのワールドなのかを示すディレクトリを作るため
# $4 compress_file_name

# args
bu_sv_port=$1
server_ip=$2
save_dir_name_sv_world=$3
compress_file_name=$4

sftp -oport="$bu_sv_port" -i ../key/key -o UserKnownHostsFile=../key/known_hosts mc-user@${server_ip} << EOF
cd saves
mkdir "$save_dir_name_sv_world"
cd "$save_dir_name_sv_world"
put "../temp/${compress_file_name}"
bye
EOF

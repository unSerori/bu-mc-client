#!/bin/bash

# sftpでの投稿

# CDに移動&初期化
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}
source ../.env

dir=hoge

# sftp -oport="2222" -b try_sftp.bat -i ../key/key -o UserKnownHostsFile=../key/known_hosts mc-user@${SERVER_IP}
sftp -oport="2222" -i ../key/key -o UserKnownHostsFile=../key/known_hosts mc-user@${SERVER_IP} <<EOF
ls
cd saves
mkdir $dir
put put_file
bye
EOF

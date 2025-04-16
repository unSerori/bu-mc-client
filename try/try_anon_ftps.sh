#!/bin/bash

# login_ftpsでの投稿

# CDに移動&初期化
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}
source ../.env

# TODO: デバッグ消す
lftp -d << EOF
set ftp:ssl-auth TLS
set ftp:ssl-force true
set ftp:ssl-allow true
set ftp:ssl-protect-list true
set ftp:ssl-protect-data true
set ftp:ssl-protect-fxp true
set ssl:check-hostname false
set ssl:verify-certificate false
set ftp:use-site-utime no
open -u anonymous, ftp://${SERVER_IP}
ls
cd saves
put put_file
close
EOF

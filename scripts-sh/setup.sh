#!/bin/bash

# バックアップスケジュールを登録
# sudo権限で実行

# CDに移動&初期化
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}
source ../.env

# 必要なツールをインストール
ssh -V &> /dev/null # ssh
if [ $? -ne 0 ]; then
    echo "Started installing the tool because I couldn't find it..."
    apt-get install -y openssh-client
else
    echo "Installed: ssh"
fi
7z &> /dev/null
if [ $? -ne 0 ]; then
    echo "Started installing the tool because I couldn't find it..."
    apt-get install -y p7zip-full
else
    echo "Installed: 7z"
fi

# buスクリプトをcronで提示実行

# 時刻
EXE_MIN="54" # 00
EXE_H="21" # 04
EXE_D="*"
EXE_MON="*"
EXE_DOW="*" # *
TIME="${EXE_MIN} ${EXE_H} ${EXE_D} ${EXE_MON} ${EXE_DOW}" # 分 時 日 月 曜日

# ファイル
TARGET_SCRIPT="cd $(pwd) && bash $(pwd)/set_tailscale_dns.sh && bash $(pwd)/bu.sh"
#TARGET_SCRIPT="bash $(pwd)/bu.sh"

# 登録済みでないなら登録
cron_job="${TIME} ${TARGET_SCRIPT}"
if ! crontab -l | grep -qF "$TARGET_SCRIPT"; then
    ( crontab -l 2> /dev/null; echo "$cron_job" ) | crontab -
fi
crontab -l
#!/bin/bash

# バックアップスケジュールを登録
# sudo権限で実行

source "$(dirname ${0})/init.sh" "../.env"

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
EXE_MIN="18" # 00
EXE_H="20" # 04
EXE_D="*"
EXE_MON="*"
EXE_DOW="*" # *
TIME="${EXE_MIN} ${EXE_H} ${EXE_D} ${EXE_MON} ${EXE_DOW}" # 分 時 日 月 曜日

# ファイル
TARGET_SCRIPT="cd $(pwd) && bash $(pwd)/scrs/set_tailscale_dns.sh && sudo -u $USER_NAME bash $(pwd)/bu.sh"

# 登録済みでないなら登録
cron_job="${TIME} ${TARGET_SCRIPT}"
if ! crontab -l | grep -qF "$TARGET_SCRIPT"; then
    ( crontab -l 2> /dev/null; echo "$cron_job" ) | crontab -
fi
crontab -l
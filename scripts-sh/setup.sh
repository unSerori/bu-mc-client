#!/bin/bash

# バックアップスケジュールを登録
# sudo権限？で実行

# CDに移動&初期化
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}
source ../.env

# TODO: アンコメント
# # 必要なツールをインストール
# ssh -V &> /dev/null # msgは破棄
# if [ $? -ne 0 ]; then
#     echo "Started installing the tool because I couldn't find it..."
#     apt-get install -y openssh-client
# else
#     echo "Installed: ssh"
# fi

# buスクリプトをcronで提示実行

# 時刻
EXE_MIN="31"
EXE_H="00"
EXE_D="*"
EXE_MON="*"
EXE_DOW="*" # *
TIME="${EXE_MIN} ${EXE_H} ${EXE_D} ${EXE_MON} ${EXE_DOW}" # 分 時 日 月 曜日

# ファイル
TARGET_SCRIPT="bash $(pwd)/try_cron_task.sh /home/unserori/bu-mc-client/"

# 登録済みでないなら登録
cron_job="${TIME} ${TARGET_SCRIPT}"
if ! crontab -l | grep -qF "$TARGET_SCRIPT"; then
    ( crontab -l 2> /dev/null; echo "$cron_job" ) | crontab -
fi
crontab -l
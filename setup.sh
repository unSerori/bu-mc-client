# TODO: 必要なツールをインストール
lftp --version &> /dev/null # msgは破棄
if [ $? -ne 0 ]; then
    echo "Started installing the tool because I couldn't find it..."
    apt-get install -y lftp
else
    echo "Installed: lftp"
fi

# TODO: cron

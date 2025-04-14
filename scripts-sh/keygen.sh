#!/bin/bash

# sshkeyを作成する

source .env

# 鍵
mkdir -p key
ssh-keygen -f key/key -q -t ed25519 -b 4096 -N ""

# ホストキー
ssh-keyscan -p 2222 -t ed25519 ${SERVER_IP} >> key/known_hosts

# 権限
chmod 700 key # 自分自身のみ
chmod 400 key/key # 秘密鍵は自分自身だけ
chmod 644 key/key.pub # 公開鍵はおｋ
chmod 644 key/known_hosts # 自身は書き換え権限が必要、othersから見られてもいい
# chmod 600 key/authorized_keys # othersに書き換えられると困る

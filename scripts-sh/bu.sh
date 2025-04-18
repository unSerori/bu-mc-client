#!/bin/bash

# 指定されたデータをバックアップする

source "$(dirname ${0})/init.sh" "../.env"

# コンテナの停止
bash "${PAUSE_CTR_SCR}"

declare -A bu_dir
while IFS=':' read -r key value; do # IFSで': 'とするとそれぞれのcharで区切ることになる、だから':'一文字で区切り空白を削除している
  [[ "$key" =~ ^[[:space:]]*# ]] && continue # インデント付きコメントに対応するため、空白が0文字以上かつ#が続くものを対象とする
  [[ -z "$key" ]] && continue

  sv_world_name=$(echo "$key" | xargs) # CONTEXT: xargsで渡し先コマンドがないと、デフォルトでecho
  dir=$(echo "$value" | xargs)
  
  echo "key: $sv_world_name"
  echo "value: $dir"

  # TODO: ファイルを圧縮して
  
  # TODO: FTP送信

done < "../dir_list.yml"

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

  # sv_worldを含めるのか問題 
  compress_file_name="${sv_world_name}_$(date +%Y%m%d%H%M%S).7z"

  # ファイルを圧縮して、
  # TODO: temp dir
  # TODO: switch
  echo sv_world_name: $sv_world_name
  echo compress_file_name: $compress_file_name
  echo COMPRESS_CMD: $COMPRESS_CMD
  eval "${COMPRESS_CMD}"
  
  # FTP送信
  ./put_sftp.sh $BU_SV_PORT "${SERVER_IP}" "${sv_world_name}" "${compress_file_name}"
done < "../dir_list.yml"

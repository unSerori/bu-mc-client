#!/bin/bash

# 指定されたデータをバックアップする

source "$(dirname ${0})/init.sh" "../.env"
source compress.sh

mkdir -p "${LOG_DIR}" "../temp"

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

  date="$(date +%Y%m%d%H%M%S)"
  fn_without_ext="${sv_world_name}_${date}" # アップロード先はディレクトリが切られているのに、sv_worldをファイル名に含める必要があるのか問題

  # ファイルを圧縮して、
  if ext=$(compress_dir "${fn_without_ext}" "$dir"); then
    echo "compress true...ext: $ext" >> "${OUT_LOG_PATH}"

    # FTP送信
    ./put_sftp.sh $BU_SV_PORT "${SERVER_IP}" "${sv_world_name}" "${fn_without_ext}.${ext}"

    # TODO: temp内削除

  else
    echo "compress false" >> "${ERR_LOG_PATH}"
  fi
done < "../dir_list.yml"

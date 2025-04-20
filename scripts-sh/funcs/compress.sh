#!/bin/bash

# ディレクトリを圧縮する

# Parameters
# $1 o_fn_without_ext: 文字列
#   圧縮後のファイル名で、拡張子抜き
# $2 dir: 文字列
#   圧縮する対象のディレクトリ

compress_dir() {
  local o_fn_without_ext="${1}"
  local dir="${2}"

  local o_dir="${SCR_BS_DIR}/../temp/"
  local o_path="${o_dir}${o_fn_without_ext}"

  # 圧縮率が高いと思われる方法順で圧縮を試みる
  {  
    echo
    echo "date: $(date)"
    echo "Trying compression methods in order of expected compression ratio..."
  } >> $OUT_LOG_PATH
  (
    7z a -mx=9 "${o_path}.7z" "${dir}" >> "$OUT_LOG_PATH" 2>> "$ERR_LOG_PATH" && \
    echo 7z
  ) && return 0 || ( # サブシェルなので`cd "${wd}"`で戻ってくる必要がない
    cd "$(dirname "${dir}")" && \
    tar -czvf "${o_path}.tar.gz" "$(basename "${dir}")" >> "$OUT_LOG_PATH" 2>> "$ERR_LOG_PATH" && \
    echo tar.gz
  ) && return 0 || (
    cd "$(dirname "${dir}")" && \
    zip -r -9 "${o_path}.zip" "$(basename "${dir}")" >> "$OUT_LOG_PATH" 2>> "$ERR_LOG_PATH" && \
    echo zip
  ) && return 0 || (
    {
      echo
      echo "date: $(date)"
      echo "Tried multiple compression methods, but all failed."
    } >> "$ERR_LOG_PATH"
    return 1
  )
}

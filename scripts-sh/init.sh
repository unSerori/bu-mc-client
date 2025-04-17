#!/bin/bash

# スクリプトのカレントディレクトリに移動する
# 呼び出しファイルと同じ場所に置くこと
# 読み込む.envファイルのパスを渡すこと

# CDに移動&初期化
sh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" # 実行場所を相対パスで取得し、そこにサブシェルで移動、pwdで取得
cd "$sh_dir" || {
    echo "Failure CD command."
    exit 1
}
source ${1:-./.env}

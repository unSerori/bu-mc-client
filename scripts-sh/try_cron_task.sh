#!/bin/bash

# 受け取ったディレクトリにlogを作成する
# 呼び出し側の責務: ディレクトリは最後の/を含めて渡す

echo ${1}log.log > /home/unserori/bu-mc-client/arg.log

{
echo try_cron_task.sh
echo 2
echo 3
echo 4
echo add 5
date
echo
} >> ${1}log.log

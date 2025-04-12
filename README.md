# bu-mc-client

マイクラ鯖のバックアップクライアント  

## 環境

debian12.9  

## 環境構築

1. tailscaleを入れる
2. `/etc/resolv.conf`が書き換えられる問題を解消するために、`chattr +i /etc/resolv.conf`、`/etc/resolv.pre-tailscale-backup.conf`に更新後の`/etc/resolv.conf`を追記 TODO: 現状合ってるかわからない
3. `git clone git@github.com:unSerori/bu-mc.git`でとってくる
4. `sudo bash setup.sh`を実行（TODO: sudo権限が必要）

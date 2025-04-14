# bu-mc-client

マイクラ鯖のバックアップクライアント  

## 環境

debian12.9  

## 環境構築

1. tailscaleを入れる
2. `/etc/resolv.conf`が書き換えられる問題を解消するために、TODO: 現状合ってるかわからない

    ```markdown

    - `chattr +i /etc/resolv.conf`
    - `/etc/resolv.pre-tailscale-backup.conf`に更新後の`/etc/resolv.conf`を追記
    ```

    systemd-resolvedを導入し管理する（systemd-resolvedで管理し、tailscaleでの上書きを防止）

    ```bash
    # インストール
    sudo apt-get update
    sudo apt-get install -y systemd-resolved
    # srを使うために既存の設定ファイルを上書きするためにシンボリックを作成
    `rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf`
    # `/etc/systemd/resolved.conf`の`[Resolve]`に以下のDNS設定を追加
    # DNS=8.8.8.8
    # FallbackDNS=8.8.4.4
    # 再起動
    systemctl restart systemd-resolved
    nohup sudo systemctl restart tailscaled &
    ```

3. `git clone git@github.com:unSerori/bu-mc.git`でとってくる
4. `sudo bash setup.sh`を実行（TODO: sudo権限が必要）

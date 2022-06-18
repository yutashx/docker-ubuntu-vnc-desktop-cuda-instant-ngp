# instant-ngp with Ubuntu VNC Desktop 
## What is this
Dockerコンテナ上でUbuntu Desktopを作成し、VNCで接続し、instant-ngpを動かす。

## How to use
サーバー上で以下のコマンドを実行
```
$ git clone --recursive https://github.com/yutashx/docker-ubuntu-vnc-desktop-cuda-instant-ngp.git
$ cd ubuntu-vnc-desktop-instant-ngp
$ make build_image
$ make run_image
```

ローカルのブラウザーで`<サーバーのアドレス>:6080`を開き、ユーザーは$USER、パスワードは`password`でアクセスできる。
ターミナルを開き、依存パッケージをインストールする。パスワードは`password`を入力する。
```
$ cd /home/$USER/workspace
$ make install_deps
```

instant-ngpをインストールする
```
$ make build_ngp
```

instant-ngpのサンプルのfoxを実行する。
```
$ make ngp_fox
```

## Notes
[fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)で提供されているDockerfileを元に、base imageをubuntu:20.04からnvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04に変更することで作成している。
他者が無断で使用できないようにHTTP Base Authenticationを設定しておくことをお勧めする。
その他にSSLやScreen Resolutionも設定できる。

現在の使用ではglxgearsやDonkey CarはGPUを利用できない。（誰かpull request出してくれると助かる）

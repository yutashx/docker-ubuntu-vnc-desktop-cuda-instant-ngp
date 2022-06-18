# Docker Ubuntu VNC Desktop
## What is this
Dockerコンテナ上でUbuntu Desktopを作成し、VNCで接続できる。
また、OpenGLが動き、Nvidia GPUも使用することができる。

## How to use
サーバー上で以下のコマンドを実行
```
$ git clone <this repository>
$ cd <this repository>
$ docker build -t ${USER}_ubuntu_desktop_vnc .
$ docker run --rm --gpus all -p 6080:80 shm-size=512m -e HTTP_PASSWORD=password -e USER=ubuntu -e PASSWORD=password ${USER}_ubuntu_desktop_vnc:latest
```

ローカルのブラウザーで`<サーバーのアドレス>:6080`を開き、ユーザーを`root`、パスワードを`password`にするこでアクセスできる。

## Notes
[fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)で提供されているDockerfileを元に、base imageをubuntu:20.04からnvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04に変更することで作成している。
他者が無断で使用できないようにHTTP Base Authenticationを設定しておくことをお勧めする。
その他にSSLやScreen Resolutionも設定できる。

現在の使用ではglxgearsやDonkey CarはGPUを利用できない。（誰かpull request出してくれると助かる）

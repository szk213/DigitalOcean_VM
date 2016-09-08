#!/bin/bash
#xrdp,vncをインストール
sudo yum -y install epel-release
sudo yum -y install xrdp
sudo yum -y install tigervnc-server

# デスクトップ環境をインストール
sudo yum -y groups install "GNOME Desktop"
sudo systemctl set-default graphical.target

# 元のcolor設定ではリモートログイン時にエラーになるため、32bitから24bitに変更
sudo sed -i -e 's/max_bpp=32/max_bpp=24/g' /etc/xrdp/xrdp.ini

# 日本語環境のインストールと設定
sudo yum -y install ibus-kkc vlgothic-*
sudo localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf

# リモートログイン時の日本語設定
if grep -e 'export LANG=ja_JP.UTF-8' /etc/xrdp/startwm.sh; then
  :
else
  sudo sed -i -e 's/#export LANG=$LANG/#export LANG=$LANG\nexport LANG=ja_JP.UTF-8/g' /etc/xrdp/startwm.sh
fi

# xrdpで使用するポートを開放
sudo systemctl start firewalld.service
sudo firewall-cmd --permanent --zone=public --add-port=3389/tcp
sudo firewall-cmd --reload

# xrdpのサービスを起動し、自動起動を有効
sudo systemctl start xrdp.service
sudo systemctl enable xrdp.service

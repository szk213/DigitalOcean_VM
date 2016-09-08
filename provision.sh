#!/bin/bash
#xrdp,vnc�򥤥󥹥ȡ���
sudo yum -y install epel-release
sudo yum -y install xrdp
sudo yum -y install tigervnc-server

# �ǥ����ȥå״Ķ��򥤥󥹥ȡ���
sudo yum -y groups install "GNOME Desktop"
sudo systemctl set-default graphical.target

# ����color����Ǥϥ�⡼�ȥ�������˥��顼�ˤʤ뤿�ᡢ32bit����24bit���ѹ�
sudo sed -i -e 's/max_bpp=32/max_bpp=24/g' /etc/xrdp/xrdp.ini

# ���ܸ�Ķ��Υ��󥹥ȡ��������
sudo yum -y install ibus-kkc vlgothic-*
sudo localectl set-locale LANG=ja_JP.UTF-8
source /etc/locale.conf

# ��⡼�ȥ�����������ܸ�����
if grep -e 'export LANG=ja_JP.UTF-8' /etc/xrdp/startwm.sh; then
  :
else
  sudo sed -i -e 's/#export LANG=$LANG/#export LANG=$LANG\nexport LANG=ja_JP.UTF-8/g' /etc/xrdp/startwm.sh
fi

# xrdp�ǻ��Ѥ���ݡ��Ȥ���
sudo systemctl start firewalld.service
sudo firewall-cmd --permanent --zone=public --add-port=3389/tcp
sudo firewall-cmd --reload

# xrdp�Υ����ӥ���ư������ư��ư��ͭ��
sudo systemctl start xrdp.service
sudo systemctl enable xrdp.service

#! /bin/sh

# Short URL: https://git.io/vHXIB

# Run with: wget https://git.io/vHXIB -O - | sh

if [ -f /etc/os-release ]; then
  . /etc/os-release
fi

SERVICE=sshd

if [ "$ID_LIKE" = 'debian' ]; then
  apt install -y openssh-server
  SERVICE=ssh
fi

if [ "$ID_LIKE" = 'arch' ]; then
  pacman --noconfirm -S openssh
fi

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak_$(date +%s)

cat << EOF >> /etc/ssh/sshd_config
# Added by bootstrapping-for-ansible.sh
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes
EOF

systemctl start "$SERVICE".service
systemctl enable "$SERVICE".service

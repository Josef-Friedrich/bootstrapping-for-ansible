#! /bin/sh

# Short URL: https://git.io/vHXIB

# Run with: wget https://git.io/vHXIB -O - | sh

DISTRO=$(lsb_release -si)
SERVICE=sshd

if [ "$DISTRO" = 'Ubuntu' ]; then
  apt install openssh-server
  SERVICE=ssh
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

echo lol

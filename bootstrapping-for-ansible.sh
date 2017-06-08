#! /bin/sh

# Short URL: https://git.io/vHXIB

# Run with: wget https://git.io/vHXIB -O - | sh

su

passwd

cat << EOF > /etc/ssh/sshd_conf
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes
EOF

systemctl start sshd.service
systemctl enable sshd.service

echo lol

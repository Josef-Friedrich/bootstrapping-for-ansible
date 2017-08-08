#! /bin/sh

# Short URL: https://git.io/vHXIB

# Run with: wget https://git.io/vHXIB -O - | sh

if [ -f /etc/os-release ]; then
  . /etc/os-release
fi

SERVICE=sshd

if [ "$ID_LIKE" = 'debian' ]; then
  sudo apt install -y openssh-server
  SERVICE=ssh
fi

if [ "$ID_LIKE" = 'arch' ]; then
  sudo pacman --noconfirm -S openssh
fi

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak_$(date +%s)

sudo cat << EOF | sudo tee -a /etc/ssh/sshd_config
# Added by bootstrapping-for-ansible.sh
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes
EOF

sudo systemctl restart "$SERVICE".service
sudo systemctl enable "$SERVICE".service

IP=$(hostname -I | awk '{print $1}')

KEYS='ssh_host_ecdsa_key
ssh_host_ecdsa_key.pub
ssh_host_ed25519_key
ssh_host_ed25519_key.pub
ssh_host_rsa_key
ssh_host_rsa_key.pub'

for KEY in $KEYS; do
  if [ ! -f /etc/ssh/$KEY ]; then
    echo "Key file doesn’t exist: /etc/ssh/$KEY"
  fi
done

echo "Login: ssh $USER@$IP"

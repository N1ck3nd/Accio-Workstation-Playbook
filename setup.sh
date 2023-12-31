#!/bin/bash

cd $HOME
REPO_URL="https://github.com/N1ck3nd/Accio-Workstation-Playbook.git"
APT_PACKAGES="git curl python3 python3-pip"
export ANSIBLE_FOLDER_PATH="$HOME/Accio-Workstation-Playbook"
export PATH=$PATH:/$HOME/.local/bin

echo ''
echo 'PREPARE [Installing Ansible.] *********************************'
echo ''
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install $APT_PACKAGES -y >/dev/null 2>&1
python3 -m pip install $PIP_DEPENDENCIES > /dev/null 2>&1
git clone $REPO_URL >/dev/null 2>&1

### BEGIN - OPTIONAL PRIVATE .dotfiles REPO

echo ''
echo 'PREPARE [Loading GitHub SSH Key.] *********************************'
echo ''

FILE=$HOME/.ssh/github_id
DEST=$HOME/.dotfiles

if [ ! -f "$FILE" ]; then
    open https://github.com/login/
    exit
fi

chmod 600 $FILE

PATTERN=$(ssh-add -l | grep '@live.nl')
if [ -z "$PATTERN" ]; then
  eval "$(ssh-agent -s)"
  echo ''
  sleep 2
  script -q /dev/null -c "ssh-add $FILE"
  echo ''
  ssh -T git@github.com
fi

echo ''
echo 'RUN [Cloning .dotfiles Repository.] ***************************************'
echo ''

git clone git@github.com:N1ck3nd/.dotfiles.git $DEST

### END - OPTIONAL

sudo echo ''
echo 'PREPARE [Installing requirements with Ansible-Galaxy.] ********'
echo ''
ansible-galaxy install -r $ANSIBLE_FOLDER_PATH/requirements.yml >/dev/null 2>&1

echo 'RUN [Running playbook.] ***************************************'
ansible-playbook $ANSIBLE_FOLDER_PATH/playbook.yml -i $ANSIBLE_FOLDER_PATH/inventory.yml

echo -e '\e[35m[WARNING]: Please reboot the system to apply all changes.'
echo ''
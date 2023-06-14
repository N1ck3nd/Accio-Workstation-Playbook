#!/bin/bash
REPO_NAME="https://github.com/N1ck3nd/Accio-Workstation-Playbook.git"
APT_PACKAGES="git curl python3 python3-pip"
export ANSIBLE_FOLDER_PATH="$HOME/Accio-Workstation-Playbook"
export PATH=$PATH:/$HOME/.local/bin

echo ''
echo 'PREPARE [Installing Ansible.] *********************************'
echo ''
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install $APT_PACKAGES -y >/dev/null 2>&1
python3 -m pip install $PIP_DEPENDENCIES > /dev/null 2>&1
git clone $REPO_URL $ANSIBLE_FOLDER_PATH >/dev/null 2>&1

sudo echo ''
## echo 'PREPARE [Installing requirements with Ansible-Galaxy.] ********'
## echo ''
## ansible-galaxy install -r $FOLDER_PATH/requirements.yml >/dev/null 2>&1

echo 'RUN [Running playbook.] ***************************************'
ansible-playbook $ANSIBLE_FOLDER_PATH/playbook.yml -i $ANSIBLE_FOLDER_PATH/inventory.yml

echo -e '\e[35m[WARNING]: Please reboot the system to apply all changes.'
echo ''
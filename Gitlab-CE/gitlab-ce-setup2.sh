#!/bin/bash
clear
sudo systemctl stop apache2
sudo apt update && sudo apt full-upgrade -y
sudo apt install curl openssh-server ca-certificates tzdata perl -y
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
ip=$(hostname -I | awk '{print $1}')
export GITLAB_URL="http://$ip"
sudo EXTERNAL_URL="${GITLAB_URL}" apt install gitlab-ce -y
sudo gitlab-ctl reconfigure
clear

file_path="/etc/gitlab/initial_root_password"

if [ -f "$file_path" ]; then
    echo "Arquivo initial_root_password encontrado em $file_path"
    password=$(grep "Password" "$file_path" | awk '{print $2}')
    echo "Senha padrão encontrada no arquivo: $password"
else
    echo "Arquivo initial_root_password não encontrado em $file_path"
fi
clear
ip=$(hostname -I | awk '{print $1}')
echo "==============================================================="
echo "-- Acesse o Gitlab-CE pelo seguinte link: https://$ip          "
echo "==============================================================="
echo "login: root"
echo "senha: $password"

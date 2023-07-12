!# /bin/bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install curl openssh-server ca-certificates tzdata perl -y
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
ip=$(hostname -I | awk '{print $1}')
export GITLAB_URL="http://$ip"
sudo EXTERNAL_URL="${GITLAB_URL}" apt install gitlab-ce
sudo gitlab-ctl reconfigure
ip=$(hostname -I | awk '{print $1}')
clear
echo "Acesse o Gitlab-CE pelo seguinte link: http://$ip"
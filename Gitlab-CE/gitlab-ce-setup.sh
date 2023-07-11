!# /bin/bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install curl vim openssh-server ca-certificates -y
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
ip=$(hostname -I | awk '{print $1}')
export GITLAB_URL="http://$ip"
sudo gitlab-ctl reconfigure
clear
ip=$(hostname -I | awk '{print $1}')
echo "Acesse o Gitlab-CE pelo seguinte link: https://$ip"

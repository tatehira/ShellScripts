!# /bin/bash
clear
sudo apt update && sudo apt full-upgrade -y
<<<<<<< HEAD
sudo apt install curl openssh-server ca-certificates tzdata perl -y
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
=======
sudo apt install curl vim openssh-server ca-certificates -y
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
>>>>>>> 8a808f1cdfaebfff4e6e0a6f7fc6f6bc1af7b754
ip=$(hostname -I | awk '{print $1}')
export GITLAB_URL="http://$ip"
sudo EXTERNAL_URL="${GITLAB_URL}" apt install gitlab-ce
sudo gitlab-ctl reconfigure
<<<<<<< HEAD
ip=$(hostname -I | awk '{print $1}')
clear
echo "Acesse o Gitlab-CE pelo seguinte link: http://$ip"
=======
clear
echo "Acesse o Gitlab-CE pelo seguinte link: https://$ip"
>>>>>>> 8a808f1cdfaebfff4e6e0a6f7fc6f6bc1af7b754

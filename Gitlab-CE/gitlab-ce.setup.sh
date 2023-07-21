#!/bin/bash

# Shell script para instalação do GitLab CE e exibição da senha do usuário root

while true; do
    clear
    echo "===== Menu ====="
    echo "1. Instalação do GitLab CE"
    echo "2. Exibir senha do usuário root"
    echo "3. Sair"
    echo "================"
    read -p "Digite o número da operação desejada: " choice

    case $choice in
        1)
            clear
            sudo systemctl stop apache2
            sudo apt update && sudo apt full-upgrade -y
            sudo apt install curl openssh-server ca-certificates tzdata perl -y
            touch /etc/gitlab/RootPassword.txt
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
            $password >> /etc/gitlab/RootPassword.txt
            sleep 20
            ;;
        2)
            clear
            file_path="/etc/gitlab/initial_root_password"

            if [ -f "$file_path" ]; then
                echo "Arquivo initial_root_password encontrado em $file_path"
                
                # Obtém a senha do arquivo
                password=$(grep "Password" "$file_path" | awk '{print $2}')
                echo "Senha do usuário root: $password"
                sleep 5
            else
                echo "Diretório /etc/gitlab não encontrado!"
                echo "O GitLab CE não foi instalado."
                sleep 5
            fi
            ;;
        3)
            clear
            echo "Saindo do script..."
            exit
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            sleep 2
            ;;
    esac
done

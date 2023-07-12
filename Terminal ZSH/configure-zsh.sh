#!/bin/bash
clear

# Instalação do Zsh
sudo apt install -y zsh

# Instalação do Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Definindo o Zsh como o shell padrão
chsh -s $(which zsh)

# Download do tema Agnoster
mkdir -p ~/.oh-my-zsh/themes
wget -O ~/.oh-my-zsh/themes/agnoster.zsh-theme https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/agnoster.zsh-theme

# Configurando o tema no arquivo .zshrc
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' ~/.zshrc

# Recarregando as configurações do Zsh
source ~/.zshrc
clear

echo "Configuração do Zsh concluída."

# Reiniciando o shell com o Zsh
exec zsh

!# /bin/bash
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"]
zsh
cd ~/.oh-my-zsh/themes
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/agnoster.zsh-theme
theme="agnoster"
nano ~/.zshrc
sed -i "s/^ZSH_THEME=.*/ZSH_THEME=\"$theme\"/" ~/.zshrc
source ~/.zshrc
echo "Saving changes and exiting..."
sleep 1
chsh -s /usr/bin/zsh
zsh
clear


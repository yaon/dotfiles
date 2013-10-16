user=yaon
apt-get install -y vim git tmux gnome-terminal tree zsh sudo

#dotfiles config
cd /home/$user
git clone https://github.com/$user/dotfiles tools
cp -r tools/.vimrc tools/.zshrc tools/.gitconfig tools/.ssh /home/$user
mkdir -p .vim/bundle
chown yaon:yaon -R /home/\$\{\u\s\e\r\}.vim
git clone https://github.com/gmarik/vundle.git /home/$user/.vim/bundle/vundle
vim +BundleInstall +qall

chsh -s $(which zsh) $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "$user ALL=NOPASSWD:/sbin/poweroff" >> /etc/sudoers
echo "$user ALL=NOPASSWD:/sbin/reboot" >> /etc/sudoers


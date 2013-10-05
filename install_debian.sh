sudo apt-get install -y vim git tmux gnome-terminal tree
sudo apt-get install -y python-3.2 pip-3.2 django
sudo pip install virtualenv
# nosql for django
sudo pip install git+https://github.com/django-nonrel/django@nonrel-1.3
sudo pip install git+https://github.com/django-nonrel/djangotoolbox@toolbox-1.3
# mongodb
sudo pip install git+https://github.com/django-nonrel/mongodb-engine@mongodb-engine-1.3
# node.js
mkdir ~/src && cd $_
wget -N http://nodejs.org/dist/node-latest.tar.gz
tar xzvf node-latest.tar.gz && cd node-*
./configure
make
sudo make install

# sudo curl http://npmjs.org/install.sh | sh
sudo npm install -g typescript

#dotfiles config
cd ~
git clone https://github.com/yaon/dotfiles tools
cp -r tools/.vimrc tools/.zshrc tools/.gitconfig tools/.ssh ~
mkdir -p .vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

sudo chsh -s $(which zsh) jim
echo 'yaon ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo 'yaon ALL=NOPASSWD:/sbin/poweroff' >> /etc/sudoers
echo 'yaon ALL=NOPASSWD:/sbin/reboot' >> /etc/sudoers

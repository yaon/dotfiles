apt-get install -y vim git tmux gnome-terminal tree
apt-get install -y python-3.2 pip-3.2 django
pip install virtualenv
# nosql for django
pip install git+https://github.com/django-nonrel/django@nonrel-1.3
pip install git+https://github.com/django-nonrel/djangotoolbox@toolbox-1.3
# mongodb
pip install git+https://github.com/django-nonrel/mongodb-engine@mongodb-engine-1.3
# node.js
mkdir ~/src && cd $_
wget -N http://nodejs.org/dist/node-latest.tar.gz
tar xzvf node-latest.tar.gz && cd node-*
./configure
make
make install

# sudo curl http://npmjs.org/install.sh | sh
npm install -g typescript

#dotfiles config
cd ~
git clone https://github.com/yaon/dotfiles tools
cp -r tools/.* ~
mkdir -p .vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall

chsh -s $(which zsh) jim
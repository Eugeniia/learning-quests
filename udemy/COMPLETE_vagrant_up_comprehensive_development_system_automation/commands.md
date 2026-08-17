## 1. Quick Start Commands

vagrant help
vagrant help init
vagrant init hashicorp/precise64
vagrant up
vagrant ssh
nano Vagrantfile
vagrant suspend
vagrant status
vagrant halt
vagrant destroy

## 2. Vagrant with Git
which git
git version
git init
git add Vagrantfile
git commit -m "Adding initial files"
git log --oneline
git status

## 3. Vagrant Boxes
vagrant help box
vagrant box list -h
cd .vagrant.d/
cd boxes/
cd hashicorp-VAGRANTSLASH-precise64/
vagrant box list
vagrant box add ubuntu/trusty64
vagrant box list
vagrant init ubuntu/trusty64
vagrant box list
vagrant box outdated
vagrant box update
vagrant box remove hashicorp/precise64

## 4. Plugins
vagrant help plugin
vagrant plugin list
vagrant plugin install vagrant-vbguest
vagrant plugin update
vagrant plugin uninstall vagrant-vbguest

## 5. Baked LAMP
pwd
cd projects/
mkdir baked-lamp
cd baked-lamp
vagrant init chef/centos-6.5
mate Vagrantfile # enable port forwarding
vagrant ssh # enter VM
clear
sudo yum update -y
clear
sudo yum install -y nano git unzip screen
clear
sudo yum install -y httpd httpd-devel httpd-tools
clear
sudo chkconfig --add httpd
sudo chkconfig httpd on
sudo service httpd stop
cd /var/www/html
ls
cd ..
ls
sudo rm -rf html
ls
sudo ln -s /vagrant /var/www/html
exit
ls
mate index.html
ls
pwd
vagrant ssh # back into VM
sudo service httpd start
exit
vagrant ssh
clear
sudo yum install -y php php-cli php-common php-devel php-mysql
sudo service httpd restart
exit
pwd
mate info.php
ls
vagrant ssh
clear
sudo yum install -y mysql mysql-server mysql-devel
sudo chkconfig --add mysqld
sudo chkconfig mysqld on
sudo service mysqld start
mysql -u root -e "CREATE DATABASE IF NOT EXISTS dev_test";
mysql -u root -e "SHOW DATABASES";
exit
vagrant help package
vagrant status
vagrant package --output centos-lamp.box
clear
ls
vagrant box add centos-lamp centos-lamp.box
cd ..
clear
mkdir test-lamp
cd test-lamp/
vagrant box list
vagrant init centos-lamp
mate Vagrantfile
clear
vagrant plugin install vagrant-vbguest
clear
vagrant up
ls
mate index.html

## 6. File Provisioner
pwd
mkdir vagrant
cd vagrant/
mkdir files
cd files
pwd
which git
git config --global user.name "Jason Taylor" # replace with your actual name
git config --global user.email "jason@screencasts.pro" # replace with your email
git config --global --list
cat ~/.gitconfig
cp ~/.gitconfig git-config
ls
cd ~
clear
cd projects/
ls 
mkdir git-box
cd git-box/
ls
vagrant box list
vagrant init chef/centos-6.5
vagrant plugin list
mate Vagrantfile # disable vbguest auto update
vagrant up
clear
pwd
ls -la
exit
mate Vagrantfile # configure file provisioner
vagrant status
vagrant provision
vagrant ssh
ls -al
cat .gitignore
exit
clear
vagrant destroy
clear
vagrant up # test file provisioner with fresh vagrant up
vagrant ssh
ls -al
cat .gitconfig
exit
vagrant destroy

## 7. Shell Provisioner
pwd
cd projects/
cd git-box/
ls
vagrant status
mate Vagrantfile # config inline shell script
vagrant up
vagrant ssh
which git
git version
exit
mate Vagrantfile # config heredoc shell script
vagrant status
vagrant provision
clear
mate Vagrantfile
cd
cd vagrant/
ls
mkdir scripts
cd scripts/
mate provision.sh
ls
pwd
cd ~/projects/git-box/
mate Vagrantfile # config external shell script
vagrant destroy
vagrant up
vagrant ssh
git version
which nano
exit
vagrant destroy

## 8. LAMP Stack Provisioning
pwd
cd vagrant/
ls
git init
git add .
git status
git commit -m "initial commit"
git remote add origin git@github.com:screencasts-pro/vagrant.git # use your own repository
git push -u origin master
cd scripts/
ls
mate centos-lamp.sh # write shell provisioning script
cd ..
cd files/
pwd
ls
mate index.html # create simple webpage
mate info.php # create php file to call phpinfo()
cd ..
pwd
git status
git add .
git status
git commit -m "adding files for LAMP stack"
git push origin master # -u is not required
cd scripts/
mate centos-lamp.sh # configure to download index.html and info.php from GitHub
cd ..
pwd
git status
git commit -am "Updated LAMP script with GitHub files"
git push origin master
cd
clear

cd projects/
git init shell-lamp
cd shell-lamp/
pwd
vagrant box list
vagrant init chef/centos-6.5
mate Vagrantfile # enable port forwarding, disable vbguest update, add file and shell provisioners
echo ".vagrant" >> .gitignore
git add .
git commit -m "initial commit"
clear
ls
ls -al
clear
vagrant up # notice problem
mate Vagrantfile # fix problem
clear
vagrant up
ls
mate index.html # make changes
vagrant destroy
clear

## 9. Multiple Virtual Machines
pwd
cd vagrant/
cd scripts/
ls
mate centos-lamp.sh
mate centos-common.sh
mate centos-lamp.sh
mate centos-web.sh
mate centos-database.sh
ls
cd ..
git add .
git status
git commit -m "Adding files for multi-vm setup"
git push origin master
clear
cd projects/
git init multi-vms
cd multi-vms/
cp ../shell-lamp/Vagrantfile .
ls
mate Vagrantfile # configure scripts for multi-vm setup
git status
git add .
git commit -m "initial commit"
clear
vagrant up web
vagrant status
vagrant up db
vagrant status
vagrant status web
clear
vagrant halt db
vagrant halt web
vagrant status
vagrant up # brings up both
clear
vagrant ssh web
ifconfig | grep inet
ssh 192.168.10.3
ifconfig | grep inet
exit
clear
nc -z -w1 192.168.10.3 3306
exit
vagrant halt
cd


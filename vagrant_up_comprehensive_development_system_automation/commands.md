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


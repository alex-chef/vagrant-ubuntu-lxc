#
# Cookbook Name:: vagrant-ubuntu-lxc2
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# include_recipe 'apt'

execute "apt-get-update" do
  user "root"
  command "apt-get -y update"
  returns 0
end

execute "apt-get-install-lxc" do
  user "root"
  command "apt-get -y install lxc wget build-essential"
  returns 0
end

execute "wget_vagrant_1.6.5_x86_64" do
  user "root"
  cwd "/tmp"
  command "wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb"
  creates "/tmp/vagrant_1.6.5_x86_64.deb"
  returns 0
end

execute "dpkg-install-vagrant" do
  user "root"
  cwd "/tmp"
  command "dpkg -i vagrant_1.6.5_x86_64.deb"
  returns 0
end

execute "vagrant-install-plugin-vagrant-lxc" do
  user "root"
  command "vagrant plugin install vagrant-lxc"
  returns 0
end

execute "vagrant-install-plugin-chef-zero" do
  user "root"
  command "vagrant plugin install chef-zero"
  returns 0
end

execute "vagrant-install-plugin-vagrant-omnibus" do
  user "root"
  command "vagrant plugin install vagrant-omnibus"
  returns 0
end

execute "vagrant-install-plugin-vagrant-berkshelf" do
  user "root"
  command "vagrant plugin install vagrant-berkshelf"
  returns 0
end


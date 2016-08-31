#!/usr/bin/env bash
if [ -f "/var/vagrant_prepare" ]; then
 exit 0
fi
touch /var/vagrant_prepare

mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl http://mirrors.163.com/.help/CentOS7-Base-163.repo -o /etc/yum.repos.d/CentOS-Base.repo
yum localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum clean all && yum makecache

yum -y install gcc-c++ patch readline readline-devel zlib zlib-devel
yum -y install libyaml-devel libffi-devel openssl-devel make
yum -y install bzip2 autoconf automake libtool bison iconv-devel sqlite-devel
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && curl -L get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm install 2.3.1
rvm use 2.3.1 --default
echo -e “install: –no-rdoc –no-ri\nupdate: –no-rdoc –no-ri” >> ~/.gemrc
gem sources --remove https://rubygems.org/ && gem sources -a https://ruby.taobao.org/ 
gem install bundler && bundle config mirror.https://rubygems.org https://ruby.taobao.org
gem install puppet

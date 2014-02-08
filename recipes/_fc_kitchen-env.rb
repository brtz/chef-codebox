# Encoding: UTF-8
# Copyright (c) 2014, Nils Bartels, see LICENSE for details

deb_virtualbox = "#{Chef::Config[:file_cache_path]}/virtualbox_#{node['codebox']['kitchen-env']['virtualbox']['version']}.deb"
deb_vagrant = "#{Chef::Config[:file_cache_path]}/vagrant_#{node['codebox']['kitchen-env']['vagrant']['version']}.deb"

remote_file deb_virtualbox do
  source node['codebox']['kitchen-env']['virtualbox']['url']
  mode "0644"
  not_if { ::File.exists?(deb_virtualbox) }
end

remote_file deb_vagrant do
  source node['codebox']['kitchen-env']['vagrant']['url']
  mode "0644"
  not_if { ::File.exists?(deb_vagrant) }
end

# dependencies
node['codebox']['kitchen-env']['dependencies'].each do |pckg|
  package pckg do
    action :upgrade
  end
end

dpkg_package 'virtualbox' do
  source deb_virtualbox
  version node['codebox']['kitchen-env']['virtualbox']['version']
  action :install
end

package 'dkms' do
  action :upgrade
end

dpkg_package 'vagrant' do
  source deb_vagrant
  version node['codebox']['kitchen-env']['vagrant']['version']
  action :install
end

gem_package 'bundler' do
  action :upgrade
end

gem_package 'test-kitchen' do
  action :upgrade
end

gem_package 'kitchen-vagrant' do
  action :upgrade
end



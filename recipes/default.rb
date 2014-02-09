# Encoding: UTF-8
# Copyright (c) 2014, Nils Bartels, see LICENSE for details

# we need some stuff first
include_recipe 'codebox::_prerequisites'

# install defined further components
node['codebox']['further_components'].each do |component|
  include_recipe 'codebox::_fc_' + component
end unless node['codebox']['further_components'].empty?

# lets get our users from data bag
db_users = data_bag_item('codebox', node['codebox']['data_bags']['users_name'])

# we need to seperate users
db_users['entries'].each do |user, details|
  # npm install codebox
  # @TODO unless already installed
  bash 'install codebox for user: ' + user do
    cwd details['home']
    user user
    code <<-EOH
      npm install codebox
    EOH
  end unless `npm list | grep -q codebox`

  directory details['home'] + '/workspace' do
    owner user
    group user
    mode 0755
    action :create
  end

  config = {}
  config['user'] = user
  config['home'] = details['home']
  config['port'] = details['port']
  config['nginx_port'] = details['nginx_port']
  config['password_enabled'] = details['password_enabled']

  # rubocop:disable HashSyntax
  template '/etc/init.d/codebox_' + config['port'].to_s do
    source 'startscripts/' + node.platform + '/codebox.init.erb'
    mode 0755
    owner 'root'
    group 'root'
    variables(:config => config)
    action :create
  end

  service 'codebox_' + config['port'].to_s do
    supports :status => true, :restart => true
    action [:enable, :start]
  end

  template node['nginx']['dir'] + 'codebox_' + config['port'].to_s do
    source 'nginx/htpasswd.erb'
    mode 0740
    owner node['nginx']['user']
    group node['nginx']['user']
    variables(:config => config)
    action :create
  end if config['password_enabled']

  template node['nginx']['dir'] + '/sites-available/codebox_' + config['port'].to_s do
    source 'nginx/site.erb'
    mode 0755
    owner node['nginx']['user']
    group node['nginx']['user']
    variables(:config => config)
    action :create
  end
  # rubocop:enable HashSyntax

  nginx_site 'codebox_' + config['port'].to_s
end

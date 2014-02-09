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
  unless node['codebox']['known_users'].include?(user)
    bash 'install codebox for user: ' + user do
      cwd details['home']
      user user
      code <<-EOH
        npm install codebox
      EOH
    end
    new_known_users = []
    node['codebox']['known_users'].each do |known_user|
      new_known_users.push(known_user)
    end
    new_known_users.push(user)

    directory details['home'] + '/workspace' do
      owner user
      group user
      mode 0755
      action :create
    end

    last_used_port = node['codebox']['last_used_port']
    port_to_use = last_used_port + 1

    config = {}
    config['user'] = user
    config['home'] = details['home']
    config['port'] = port_to_use.to_s
    config['nginx_port'] = port_to_use - 10000;

    template '/etc/init.d/codebox_' + port_to_use.to_s do
      source 'startscripts/' + node.platform + '/codebox.init.erb'
      mode 0755
      owner 'root'
      group 'root'
      # rubocop:disable HashSyntax
      variables(:config => config)
      # rubocop:enable HashSyntax
      action :create
    end

    service 'codebox_' + config['port'] do
      supports :status => true, :restart => true
      action [ :enable, :start ]
    end
    
    template node['nginx']['dir'] + '/sites-available/codebox_' + config['port'] do
      source 'nginx/site.erb'
      mode 0755
      owner node['nginx']['user']
      group node['nginx']['user']
      # rubocop:disable HashSyntax
      variables(:config => config)
      # rubocop:enable HashSyntax
      action :create
    end

    nginx_site 'codebox_' + config['port']

    node.normal['codebox']['last_used_port'] = port_to_use
    node.normal['codebox']['known_users'] = new_known_users
  end

end

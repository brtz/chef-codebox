# Encoding: UTF-8
# Copyright (c) 2014, Nils Bartels, see LICENSE for details

# we need some stuff first
include_recipe 'codebox::_prerequisites'

# install defined further components
node['codebox']['further_components'].each do |component|
  include_recipe 'codebox::_fc_' + component
end unless node['codebox']['further_components'].empty?

# lets get our data bags
db_users = data_bag_item('codebox', node['codebox']['data_bags']['users_name'])
db_projects = data_bag_item('codebox', node['codebox']['data_bags']['projects_name'])

# we need to seperate users
db_users['entries'].each do |user, details|
  # npm install codebox
  unless node['codebox']['known_users'].include?(user)
    bash "install codebox for user: " + user do
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
    node.normal['codebox']['known_users'] = new_known_users
  end
  
  # iterate through his projects
  
  # save project into known projects unless already known
  
  # iterate last port
  
  # clone project
  
  # fetch all
  
  # checkout branches
  
  # create startscript
  
  # define service
  
end

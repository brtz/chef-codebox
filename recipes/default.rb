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

# every user has projects

# Encoding: UTF-8
default['nginx']['default_site_enabled'] = false

default['codebox']['data_bags']['secret_path'] = '/etc/chef/encrypted_data_bag_secret'
default['codebox']['data_bags']['users_name'] = 'users'
default['codebox']['data_bags']['projects_name'] = 'projects'

default['codebox']['last_used_port'] = 30000
default['codebox']['known_users'] = []
default['codebox']['known_projects'] = []

default['codebox']['further_components'] = ['kitchen-env']

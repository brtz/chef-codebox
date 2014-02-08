# Encoding: UTF-8
# Copyright (c) 2014, Nils Bartels, see LICENSE for details

# we need nodejs
include_recipe "nodejs::install_from_source"

# and npm for codebox
include_recipe "nodejs::npm"

# we need nginx as proxy in front of the projects
include_recipe "nginx::default"

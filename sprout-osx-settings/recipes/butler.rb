include_recipe "sprout-osx-apps::butler"

directory "#{node['sprout']['home']}/Library/Application Support/Butler/" do
  action :create
  owner node['current_user']
end

plist_file = 'Configuration.butleritems'

cookbook_file "#{node['sprout']['home']}/Library/Application Support/Butler/#{plist_file}" do
  source plist_file
  owner node['current_user']
end

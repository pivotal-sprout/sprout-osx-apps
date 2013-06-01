directory "#{node['sprout']['home']}/#{node["workspace_directory"]}" do
  owner node['current_user']
  mode "0755"
  action :create
end

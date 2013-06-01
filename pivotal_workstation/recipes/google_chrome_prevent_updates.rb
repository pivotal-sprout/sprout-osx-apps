directory "#{node['sprout']['home']}/Library/Google" do
  owner node['current_user']
  action :create
end

directory "#{node['sprout']['home']}/Library/Google/GoogleSoftwareUpdate" do
  owner node['current_user']
  mode "111"
  action :create
end

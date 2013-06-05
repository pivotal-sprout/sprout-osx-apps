directory "/usr/local/bin" do
  owner node['current_user']
  recursive true
end

execute "your current user owns /usr/local" do
  command "chown -R #{node['current_user']} /usr/local"
end

include_recipe "pivotal_workstation::git"
brew "tmux"

remote_file "#{node['sprout']['home']}/.tmux.conf" do
  source node["tmux_conf_file_url"]
  mode "0644"
  owner node['current_user']
end

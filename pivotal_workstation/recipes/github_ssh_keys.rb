directory "#{node['sprout']['home']}/.ssh" do
  action :create
  owner node['current_user']
  group "staff"
  mode "0700"
end

file "#{node['sprout']['home']}/.ssh/known_hosts" do
  action :create_if_missing
  owner node['current_user']
  group "staff"
  mode "0644"
end

# If there is no github_project defined, we will use the name of the machine as the SSH key,
# therefore make sure we have a name first.
include_recipe "pivotal_workstation::rename_machine" unless node["github_project"]

execute "add github to knownhosts" do
  user node['current_user']
  cwd "#{node['sprout']['home']}/.ssh"
  command <<-SH
    (cat known_hosts | grep github.com) || \
    echo "github.com,207.97.227.239 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> known_hosts
  SH
end

execute "make sure .ssh/config is owned by the user" do
  command "chown #{node['current_user']} #{node['sprout']['home']}/.ssh/config"
  only_if "test -e #{node['sprout']['home']}/.ssh/config"
end

execute "create SSH key pair for Github" do
  command "ssh-keygen -N '' -f #{node['sprout']['home']}/.ssh/id_github_#{node["github_project"] || node['fqdn']}"
  user node['current_user']
  not_if "test -e #{node['sprout']['home']}/.ssh/id_github_#{node["github_project"] || node['fqdn']}"
end

execute "symlink Github key for git-project" do
  command "ln -nfs #{node['sprout']['home']}/.ssh/id_github_{#{node["github_project"] || node['fqdn']},current}"
  user node['current_user']
  only_if { node.has_key?("github_project") }
end

execute "symlink Github public key for git-project" do
  command "ln -nfs #{node['sprout']['home']}/.ssh/id_github_{#{node["github_project"] || node['fqdn']},current}.pub"
  user node['current_user']
  only_if { node.has_key?("github_project") }
end

execute "add Github configuration to .ssh/config" do
  config = "\n\nHost github.com\n  User git\n  IdentityFile #{node['sprout']['home']}/.ssh/id_github_current"
  command "echo '#{config}' >> #{node['sprout']['home']}/.ssh/config"
  not_if "grep 'id_github_current' #{node['sprout']['home']}/.ssh/config"
  user node['current_user']
end

include_recipe "pivotal_workstation::git"

::RBENV_HOME = "#{node['sprout']['home']}/.rbenv"
::RBENV_COMMAND = "/usr/local/bin/rbenv"

brew "rbenv"
brew "ruby-build"

sprout_osx_base_bash_it_enable_feature "plugins/rbenv"

directory "#{::RBENV_HOME}/plugins" do
  owner node["current_user"]
end

git "#{::RBENV_HOME}/plugins/rbenv-default-gems" do
  repository "https://github.com/sstephenson/rbenv-default-gems.git"
  user node["current_user"]
end

template "#{::RBENV_HOME}/default-gems" do
  owner node['current_user']
  source "default-gems.erb"
end

node["rbenv"]["rubies"].each do |version, options|
  rbenv_ruby_install version do
    options options
  end
end

execute "making #{node["rbenv"]["default_ruby"]} with rbenv the default" do
  not_if { node["rbenv"]["default_ruby"].nil? }
  command "rbenv global #{node["rbenv"]["default_ruby"]}"
  user node['current_user']
end

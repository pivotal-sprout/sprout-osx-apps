path_to_dockutil = '/usr/local/bin/dockutil'

cookbook_file path_to_dockutil do
  source "dockutil"
  mode "0755"
  action :create
end

apps_to_remove_from_dock = node['sprout']['apps_to_remove_from_dock']
apps_to_remove_from_dock.each do |app|
  execute "remove #{app} from dock" do
    command "#{path_to_dockutil} --remove '#{app}' --allhomes"
    only_if "#{path_to_dockutil} --find '#{app}'"
  end
end

execute "relaunch dock" do
  command "killall Dock"
end

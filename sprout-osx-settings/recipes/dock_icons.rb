package 'dockutil'

apps_to_remove_from_dock = node['sprout']['apps_to_remove_from_dock']
apps_to_remove_from_dock.each do |app|
  execute "remove #{app} from dock" do
    command "dockutil --remove '#{app}' --allhomes"
    only_if "dockutil --find '#{app}'"
  end
end

execute "relaunch dock" do
  command "killall Dock"
end

apps_to_add_to_dock = node['sprout']['apps_to_add_to_dock']
apps_to_add_to_dock.each do |app|
  execute "add #{app} to dock" do
    command "dockutil --add '#{app}' --allhomes"
    not_if "dockutil --find '#{app}'"
  end
end

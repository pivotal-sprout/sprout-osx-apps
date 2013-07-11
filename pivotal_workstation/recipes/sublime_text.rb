include_recipe "pivotal_workstation::user_owns_usr_local"

dmg_package "Sublime Text 2" do
  source "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.dmg"
  checksum "906e71e19ae5321f80e7cf42eab8355146d8f2c3fd55be1f7fe5c62c57165add"
  owner node['current_user']
end

link "/usr/local/bin/subl" do
  to "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
end

sublime_package_path = ["#{node['sprout']['home']}/Library/Application Support/Sublime Text 2", "Packages"]
sublime_user_path = sublime_package_path.dup << "User"

recursive_directories sublime_user_path do
  owner node['current_user']
end

node["sublime_text_packages"].each do |package|
  pivotal_workstation_sublime_package package["name"] do
    source package["source"]
    destination File.join(sublime_package_path)
    owner node['current_user']
  end
end

template File.expand_path("Preferences.sublime-settings", File.join(sublime_user_path)) do
  source "sublime_text-Preferences.sublime-settings.erb"
  owner node['current_user']
  action :create_if_missing
end

package_dir = "#{node['sprout']['home']}/Library/Application Support/Sublime Text 2/Installed Packages"
filename    = "Package Control.sublime-package"

recursive_directories(["#{node['sprout']['home']}/Library/Application Support", "Sublime Text 2", "Installed Packages"]) do
  owner node['current_user']
end

remote_file "#{package_dir}/#{filename}" do
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'
  owner node['current_user']
  :create_if_missing
end

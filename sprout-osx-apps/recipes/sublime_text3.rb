include_recipe "sprout-osx-base::user_owns_usr_local"

sprout_osx_apps_homebrew_cask "sublime-text3"

link "/usr/local/bin/subl" do
  to "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
end

sublime_package_path = ["#{node['sprout']['home']}/Library/Application Support/Sublime Text", "Packages"]
sublime_user_path = sublime_package_path.dup << "User"

recursive_directories sublime_user_path do
  owner node['current_user']
end

node["sublime_text_packages"].each do |package|
  sprout_osx_apps_sublime_package package["name"] do
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

package_dir = "#{node['sprout']['home']}/Library/Application Support/Sublime Text/Installed Packages"
filename    = "Package Control.sublime-package"

recursive_directories(["#{node['sprout']['home']}/Library/Application Support", "Sublime Text", "Installed Packages"]) do
  owner node['current_user']
end

remote_file "#{package_dir}/#{filename}" do
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'
  owner node['current_user']
  :create_if_missing
end

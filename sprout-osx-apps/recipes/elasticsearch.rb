include_recipe "sprout-osx-base::homebrew"

launch_agent_path = "#{node['sprout']['home']}/Library/LaunchAgents"
plist_name = "homebrew.mxcl.elasticsearch.plist"
homebrew_plist = File.expand_path(plist_name, `brew --prefix elasticsearch`.strip)
destination_plist = File.expand_path(plist_name, launch_agent_path)

directory launch_agent_path do
  owner node["current_user"]
  action :nothing
end

execute "copy elasticsearch plist" do
  command "cp -f #{homebrew_plist} #{destination_plist}"
  user node["current_user"]
  action :nothing
  notifies :create, "directory[#{launch_agent_path}]"
  not_if { File.exists?(destination_plist) && File.read(homebrew_plist) == File.read(destination_plist) }
end

execute "unload the elasticsearch plist" do
  command "launchctl unload -w #{destination_plist}"
  user node["current_user"]
  only_if { File.exists?(destination_plist) }
end

package "elasticsearch" do
  notifies :run, "execute[copy elasticsearch plist]"
  not_if { system("brew list elasticsearch > /dev/null 2>&1") }
end

execute "load the elasticsearch plist" do
  command "launchctl load -w #{destination_plist}"
  user node["current_user"]
end

unless brew_installed? "mongodb"
  brew "mongodb"

  directory "/Users/#{node['current_user']}/Library/LaunchAgents" do
    owner node['current_user']
    action :create
  end

  execute "copy mongodb plist to ~/Library/LaunchAgents" do
    command "cp `brew --prefix mongodb`/homebrew.mxcl.mongodb.plist #{node['sprout']['home']}/Library/LaunchAgents/"
    user node['current_user']
  end

  execute "load the mongodb plist into the mac daemon startup thing" do
    command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
    user node['current_user']
  end
end

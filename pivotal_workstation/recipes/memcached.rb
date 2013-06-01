unless brew_installed? "memcached"
  brew "memcached"

  directory "/Users/#{node['current_user']}/Library/LaunchAgents" do
    owner node['current_user']
    action :create
  end

  execute "copy memcached plist to ~/Library/LaunchAgents" do
    command "cp `brew --prefix memcached`/homebrew.mxcl.memcached.plist #{node['sprout']['home']}/Library/LaunchAgents/"
    user node['current_user']
  end

  execute "load the memcached plist into the mac daemon startup thing" do
    command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.memcached.plist"
    user node['current_user']
  end
end

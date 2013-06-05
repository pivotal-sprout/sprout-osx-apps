include_recipe "sprout-osx-base::homebrew"

unless brew_installed? "redis"
  brew "redis"

  directory "/Users/#{node['current_user']}/Library/LaunchAgents" do
    owner node['current_user']
    action :create
  end

  execute "copy redis plist to ~/Library/LaunchAgents" do
    command "cp `brew --prefix redis`/homebrew.mxcl.redis.plist #{node['sprout']['home']}/Library/LaunchAgents/"
    user node['current_user']
  end

  execute "load the redis plist into the mac daemon startup thing" do
    command "launchctl load -w #{node['sprout']['home']}/Library/LaunchAgents/homebrew.mxcl.redis.plist"
    user node['current_user']
  end
end

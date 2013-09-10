include_recipe "sprout-osx-base::homebrew"

execute "install jenkins via homebrew" do
  command "brew install jenkins"
  user node['current_user']
  not_if "brew list | grep '^jenkins$'"
end

['ruby-runtime', 'git-client', 'token-macro', 'rvm', 'git'].each do |plugin|
  execute "install #{plugin} plugin" do
    user node['current_user']
    command "curl -L http://updates.jenkins-ci.org/latest/#{plugin}.hpi -o ~/.jenkins/plugins/#{plugin}.hpi"
  end
end

execute "add jenkins to auto-run" do
  user node['current_user']
  command "ln -sfv /usr/local/opt/jenkins/*.plist ~/Library/LaunchAgents"
end

execute "run jenkins" do
  user node['current_user']
  command "launchctl load ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist"
end


include_recipe "homebrew"
jenkins_properties = node['sprout']['jenkins']

directory jenkins_properties['base_dir'] do
  action :create
  owner node['sprout']['user']
end

directory jenkins_properties['plugins_dir'] do
  action :create
  owner node['sprout']['user']
end

package "jenkins"

jenkins_properties['plugins'].each do |plugin|
  execute "install #{plugin} plugin" do
    user node['sprout']['user']
    command "curl -L http://updates.jenkins-ci.org/latest/#{plugin}.hpi -o #{jenkins_properties['plugins_dir']}/#{plugin}.hpi"
  end
end

link "/Users/#{node['sprout']['user']}/Library/LaunchAgents/homebrew.mxcl.jenkins.plist" do
    to "/usr/local/opt/jenkins/homebrew.mxcl.jenkins.plist"
end

execute "run jenkins" do
  user node['sprout']['user']
  command "launchctl load ~/Library/LaunchAgents/homebrew.mxcl.jenkins.plist"
end


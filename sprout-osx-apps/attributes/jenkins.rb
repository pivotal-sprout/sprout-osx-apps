default['sprout']['jenkins']['plugins'] = ['ruby-runtime', 'ssh-agent', 'git-client', 'token-macro', 'rvm', 'git']
default['sprout']['jenkins']['base_dir'] = "/Users/#{node['current_user']}/.jenkins"
default['sprout']['jenkins']['plugins_dir'] = default['sprout']['jenkins']['base_dir'] + '/plugins'

homebrew_cask 'vagrant'

node['sprout']['vagrant']['plugins'].each do |plugin|
  options = ''
  options << "--plugin-version '#{plugin[:version]}'" if plugin.has_key?(:version)
  execute "vagrant plugin install #{plugin[:name]} #{options}" do
    user node['sprout']['user']
  end
end

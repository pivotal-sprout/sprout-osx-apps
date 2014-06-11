include_recipe 'sprout-osx-apps::vagrant'

node['sprout']['vagrant']['plugins'].each do |plugin|
  options = ''
  options << "--plugin-version '#{plugin[:version]}'" if plugin.has_key?(:version)
  execute "vagrant plugin install #{plugin[:name]} #{options}" do
    user node['current_user']
  end
end

include_recipe "sprout-osx-apps::lua"
brew "luarocks"

node['sprout']['lua']['rocks'].each do |rock_name, options|
  execute "luarocks install #{rock_name} #{options}" do
    user node['current_user']
  end
end


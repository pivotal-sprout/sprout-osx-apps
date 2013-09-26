include_recipe 'sprout-osx-base::bash_it'
include_recipe 'sprout-osx-apps::hg'
include_recipe 'sprout-osx-apps::bzr'

brew 'go'

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/go.bash' do
  cookbook 'sprout-osx-apps'
end

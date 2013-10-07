include_recipe 'sprout-osx-base::bash_it'

sprout_osx_base_bash_it_custom_plugin 'bash_it/custom/python_path.bash' do
  cookbook 'sprout-osx-apps'
end

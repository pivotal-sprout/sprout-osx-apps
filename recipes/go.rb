include_recipe 'sprout-base::bash_it'
include_recipe 'sprout-osx-apps::hg'
include_recipe 'sprout-osx-apps::bzr'

package 'go'

sprout_base_bash_it_custom_plugin 'bash_it/custom/go.bash' do
  cookbook 'sprout-osx-apps'
end

execute '/usr/local/bin/go get golang.org/x/tools/cmd/godoc' do
  environment('GOPATH' => File.join(node['sprout']['home'], 'go'))
  user node['sprout']['user']
end

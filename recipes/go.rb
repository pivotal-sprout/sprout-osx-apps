include_recipe 'sprout-base::bash_it'
include_recipe 'sprout-osx-apps::hg'
include_recipe 'sprout-osx-apps::bzr'

package 'go' do
  options '--cross-compile-all'
end

sprout_base_bash_it_custom_plugin 'bash_it/custom/go.bash' do
  cookbook 'sprout-osx-apps'
end

execute '/usr/local/bin/go get code.google.com/p/go.tools/cmd/godoc' do
  environment('GOPATH' => File.join(node['sprout']['home'], 'go'))
end

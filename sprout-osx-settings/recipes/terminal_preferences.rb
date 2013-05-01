osx_defaults "Set terminal color scheme to #{node['terminal']['color_scheme']}" do
  domain 'com.apple.Terminal'
  key '"Default Window Settings"'
  string node['terminal']['color_scheme']
end

osx_defaults "Set startup terminal color scheme to #{node['terminal']['color_scheme']}" do
  domain 'com.apple.Terminal'
  key '"Startup Window Settings"'
  string node['terminal']['color_scheme']
end

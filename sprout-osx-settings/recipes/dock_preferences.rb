osx_defaults "set dock to be on #{node['dock_preferences']['orientation']}" do
  domain 'com.apple.dock'
  key 'orientation'
  string node['dock_preferences']['orientation']
  only_if { node['dock_preferences']['orientation'] }
end

osx_defaults 'set dock to autohide' do
  domain 'com.apple.dock'
  key 'autohide'
  boolean node['dock_preferences']['autohide']
  only_if { node['dock_preferences'].keys.include?('autohide') }
end

osx_defaults 'remove persistent apps from the dock' do
  domain 'com.apple.dock'
  key 'persistent-apps'
  array []
  only_if { node['dock_preferences']['clear_apps'] }
end

osx_defaults "adjusts dock size to #{node['dock_preferences']['tilesize']}" do
  domain 'com.apple.dock'
  key 'tilesize'
  integer node['dock_preferences']['tilesize']
  only_if { node['dock_preferences']['tilesize'] }
end

execute 'relaunch dock' do
  command 'killall Dock'
  only_if { !node['dock_preferences'].empty? }
end

prefs = node['sprout']['dock_preferences']

osx_defaults "set dock to be on #{prefs['orientation']}" do
  domain 'com.apple.dock'
  key 'orientation'
  string prefs['orientation']
  only_if { prefs['orientation'] }
end

osx_defaults "set dock autohide to #{prefs['autohide']}" do
  domain 'com.apple.dock'
  key 'autohide'
  boolean prefs['auto_hide']
  only_if { prefs.keys.include?('auto_hide') }
end

osx_defaults 'remove persistent apps from the dock' do
  domain 'com.apple.dock'
  key 'persistent-apps'
  array []
  only_if { prefs['clear_apps'] }
end

osx_defaults "adjusts dock size to #{prefs['tile_size']}" do
  domain 'com.apple.dock'
  key 'tilesize'
  integer prefs['tile_size']
  only_if { prefs['tile_size'] }
end

osx_defaults "adjusts dock size to #{prefs['largesize']}" do
  domain 'com.apple.dock'
  key 'largesize'
  integer prefs['largesize']
  only_if { prefs['largesize'] }
end

osx_defaults 'toggle dock magnification on/off' do
  domain 'com.apple.dock'
  key 'magnification'
  boolean prefs['magnification']
  not_if { prefs['magnification'].nil? }
end

execute 'relaunch dock' do
  command 'killall Dock'
  only_if { !prefs.empty? }
end


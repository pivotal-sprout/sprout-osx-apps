osx_defaults "set dock to be on #{node['dock_preferences']['orientation']}" do
  domain 'com.apple.dock'
  key 'orientation'
  string node['dock_preferences']['orientation']
end

osx_defaults 'set dock to autohide' do
  domain 'com.apple.dock'
  key 'autohide'
  boolean node["dock_preferences"]["autohide"] && node["dock_preferences"]["autohide"] != 'false'
end

osx_defaults 'toggle dock magnification on/off' do
  domain 'com.apple.dock'
  key 'magnification'
  boolean node['dock_preferences']['magnification']
end

execute "relaunch dock" do
  command "killall Dock"
end

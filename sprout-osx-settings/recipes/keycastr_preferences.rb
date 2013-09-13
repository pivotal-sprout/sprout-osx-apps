osx_defaults "Set KeyCastr to act as though it had been previously launched" do
  domain node.default['keycastr']['domain']
  key 'SUHasLaunchedBefore'
  boolean true
end

osx_defaults "Set KeyCastr to only cast when using command key" do
  domain node.default['keycastr']['domain']
  key 'default.commandKeysOnly'
  boolean true
end

osx_defaults "Set KeyCastr to NOT show preferences at launch" do
  domain node.default['keycastr']['domain']
  key 'alwaysShowPrefs'
  boolean false
end

osx_defaults "Set KeyCastr font size to be larger" do
  domain node.default['keycastr']['domain']
  key 'default.fontSize'
  float 36
end

osx_defaults "Set KeyCastr Window Placement, top right corner" do
  domain node.default['keycastr']['domain']
  key 'NSWindow Frame KCBezelWindow default.bezelWindow'
  string '2353 1353 200 0 0 0 2560 1418 '
end

osx_defaults "Set KeyCastr to only show in menubar (NOT dock)" do
  domain node.default['keycastr']['domain']
  key 'displayIcon'
  integer 1
end

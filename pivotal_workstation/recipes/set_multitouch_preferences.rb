osx_defaults "allow clicking by touch" do
  domain 'com.apple.driver.AppleBluetoothMultitouch.trackpad'
  key 'Clicking'
  integer 1
end

osx_defaults "allow dragging by touch" do
  domain 'com.apple.driver.AppleBluetoothMultitouch.trackpad'
  key 'Dragging'
  integer 1
end

osx_defaults "disable swipe between pages" do
  domain 'NSGlobalDomain'
  key 'AppleEnableSwipeNavigateWithScrolls'
  integer 0
end

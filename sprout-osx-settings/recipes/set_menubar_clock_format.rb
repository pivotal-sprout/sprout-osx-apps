clock_format = node['sprout']['settings']['clock_format']
osx_defaults 'turn on date & seconds for menubar clock' do
  domain 'com.apple.menuextra.clock'
  key 'DateFormat'
  string clock_format
end

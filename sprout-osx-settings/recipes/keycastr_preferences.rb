node.default['keycastr']['settings'].each do |description, data|
  osx_defaults "Set KeyCastr '#{description}' to #{data[:value]}" do
    domain node.default['keycastr']['domain']
    key data[:key]
    self.send(data[:type], data[:value])
  end
end

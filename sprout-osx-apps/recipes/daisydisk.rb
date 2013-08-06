dmg_properties = node['sprout']['daisydisk']['dmg']

dmg_package "DaisyDisk" do
  source      dmg_properties['source']
  checksum    dmg_properties['checksum']
  volumes_dir dmg_properties['volumes_dir']
  owner       node['current_user']
end

app_supportdir = "#{node['sprout']['home']}/Library/Application Support"

recursive_directories([app_supportdir, "DaisyDisk"]) do
  owner node['current_user']
end

unless node['sprout']['daisydisk']['license']['customer_name'].nil? || node['sprout']['daisydisk']['license']['registration_key'].nil?
  template "#{File.join app_supportdir, 'DaisyDisk', 'License.DaisyDisk'}" do
    source "License.DaisyDisk.erb"
    owner node['current_user']
    variables :license => node['sprout']['daisydisk']['license']
    # action :create_if_missing
    action :create
  end
end
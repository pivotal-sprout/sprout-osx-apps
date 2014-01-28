package_zip = node['sprout']['apps']['alfred']['package_zip']
package_zip_checksum = node['sprout']['apps']['alfred']['package_zip_checksum']
package_source = node['sprout']['apps']['alfred']['package_source']
app_destination = node['sprout']['apps']['alfred']['app_destination']
downloaded_file = "#{Chef::Config[:file_cache_path]}/#{package_zip}"

remote_file downloaded_file do
  source File.join(package_source, package_zip)
  checksum package_zip_checksum
end

execute "Extract #{package_zip}" do
  cwd app_destination
  command %{unzip '#{package_zip}'}
  creates File.join(app_destination, package_zip)
end

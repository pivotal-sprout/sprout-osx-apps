return unless node['platform'] == 'mac_os_x'

user = node['current_user']

package 'maven' do
  action :install
  version '3.1.1'
end
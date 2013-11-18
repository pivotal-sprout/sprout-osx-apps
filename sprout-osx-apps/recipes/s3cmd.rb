
template "#{node['sprout']['home']}/.s3cfg" do
  owner node['current_user']
  group node['etc']['passwd'][node['current_user']]['gid']
  mode '0600'
  source 's3cfg.erb'
  variables(
    :access_key => node['s3cfg']['access_key'],
    :secret_key => node['s3cfg']['secret_key']
  )
end

package "s3cmd"



template "#{node['sprout']['home']}/.s3cfg" do
  owner node['sprout']['user']
  group node['etc']['passwd'][node['sprout']['user']]['gid']
  mode '0600'
  source 's3cfg.erb'
  variables(
    :access_key => node['s3cfg']['access_key'],
    :secret_key => node['s3cfg']['secret_key']
  )
end

package "s3cmd"


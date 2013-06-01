inputrc_location = "#{node['sprout']['home']}/.inputrc"

template inputrc_location do
  owner node['current_user']
  source "inputrc.erb"
end

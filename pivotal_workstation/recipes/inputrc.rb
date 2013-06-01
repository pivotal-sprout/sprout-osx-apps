inputrc_location = "#{WS_HOME}/.inputrc"

template inputrc_location do
  owner node['current_user']
  source "inputrc.erb"
end

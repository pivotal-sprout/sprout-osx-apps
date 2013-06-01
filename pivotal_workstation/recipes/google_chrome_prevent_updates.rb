directory "#{WS_HOME}/Library/Google" do
  owner node['current_user']
  action :create
end

directory "#{WS_HOME}/Library/Google/GoogleSoftwareUpdate" do
  owner node['current_user']
  mode "111"
  action :create
end

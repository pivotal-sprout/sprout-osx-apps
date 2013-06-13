git '/usr/local/gps' do
  repository "https://github.com/slackersoft/gps"
  action :sync
end

link '/usr/local/bin/gps' do
  to '/usr/local/gps/gps'
end

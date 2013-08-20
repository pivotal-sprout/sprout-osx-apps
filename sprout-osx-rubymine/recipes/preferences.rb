preferences = node['sprout']['rubymine']['preferences']

git preferences['clone'] do
  repository preferences['repository']
  revision preferences['revision']
  action :sync
  user node['current_user']
end

subdirs = preferences['files'].map do |file|
  File.dirname(file)
end.uniq

subdirs.each do |subdir|
  recursive_directories [preferences['dir'], subdir] do
    owner node['current_user']
    mode '0755'
    recursive true
  end
end

preferences['files'].each do |file|
  link "#{preferences['dir']}/#{file}" do
    to "#{preferences['clone']}/#{file}"
    owner node['current_user']
  end
end

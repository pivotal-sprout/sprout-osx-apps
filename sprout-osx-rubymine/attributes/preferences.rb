default['sprout']['rubymine']['preferences']['repository'] = 'https://github.com/pivotal/Pivotal-Preferences-RubyMine.git'
default['sprout']['rubymine']['preferences']['revision']   = 'master'
default['sprout']['rubymine']['preferences']['clone']      = "#{Chef::Config[:file_cache_path]}/sprout-osx-rubymine-preferences"
default['sprout']['rubymine']['preferences']['dir']        = "#{node['sprout']['home']}/Library/Preferences/RubyMine50"
default['sprout']['rubymine']['preferences']['files']      = %w[
  keymaps/pivotal.xml
  templates/jasmine.xml
]

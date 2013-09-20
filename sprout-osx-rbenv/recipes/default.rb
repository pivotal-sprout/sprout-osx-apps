rubies       = node['sprout']['rbenv']['rubies']
default_ruby = node['sprout']['rbenv']['default_ruby']

brew 'rbenv'
brew 'ruby-build'

sprout_osx_base_bash_it_enable_feature 'plugins/rbenv'

rubies.each do |version, options|
  ruby_install version do
    options options
  end
end

execute "making #{default_ruby} with rbenv the default" do
  command "rbenv global #{default_ruby}"
  user node['current_user']
  not_if { default_ruby.nil? }
end

actions :install

default_action :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :opts, :kind_of => String, :default => '--appdir="/Applications"'

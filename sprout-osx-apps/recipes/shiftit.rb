include_recipe 'sprout-base::addloginitem'

app_path='/Applications/ShiftIt.app'

unless File.exists?(app_path)
  remote_file "#{Chef::Config[:file_cache_path]}/ShiftIt.zip" do
    source 'https://raw.github.com/onsi/ShiftIt/master/ShiftIt.zip'
    mode '0644'
  end

  execute 'unzip ShiftIt' do
    command "unzip #{Chef::Config[:file_cache_path]}/ShiftIt.zip ShiftIt.app/* -d /Applications/"
    user node['current_user']
    group 'admin'
  end

  # start up on login
  execute('Start ShiftIt on login') do
    command "su #{node['current_user']} -c \"addloginitem #{app_path}\""
  end

  ruby_block 'Allow ShiftIt to control your computer' do
    block do
      results = `echo "SELECT allowed FROM access WHERE client = 'org.shiftitapp.ShiftIt';" | sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db"`
      found = results.chomp != ''
      enabled = results.chomp == '1'

      if found
        if !enabled
          `echo "UPDATE access SET allowed = 1 WHERE client = 'org.shiftitapp.ShiftIt';" | sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db"`
        end
      else
        `echo "INSERT INTO access VALUES('kTCCServiceAccessibility','org.shiftitapp.ShiftIt',0,1,1,NULL);" | sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db"`
      end

    end
  end
end

unless File.exists?('/Applications/ShiftIt.app')
  remote_file "#{Chef::Config[:file_cache_path]}/ShiftIt.zip" do
    source 'https://raw.github.com/onsi/ShiftIt/master/ShiftIt.zip'
    mode '0644'
  end

  execute 'unzip ShiftIt' do
    command "unzip #{Chef::Config[:file_cache_path]}/ShiftIt.zip ShiftIt.app/* -d /Applications/"
    user node['sprout']['user']
    group 'admin'
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

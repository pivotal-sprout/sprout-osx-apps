unless File.exists?(node["flowdock_app_path"])

    remote_file "#{Chef::Config[:file_cache_path]}/flowdock.zip" do
        source node["flowdock_download_uri"]
        checksum node["flowdock_sha"]
        owner node['current_user']
    end

    execute "unzip flowdock" do
        command "unzip #{Chef::Config[:file_cache_path]}/flowdock.zip -d #{Chef::Config[:file_cache_path]}/"
        user node['current_user']
    end

    execute "copy flowdock to /Applications" do
        command "mv #{Chef::Config[:file_cache_path]}/Flowdock.app #{Regexp.escape(node["flowdock_app_path"])}"
        user node['current_user']
        group "admin"
    end

    ruby_block "test to see if Flowdock.app was installed" do
        block do
            raise "Flowdock.app was not installed" unless File.exists?(node["flowdock_app_path"])
        end
    end

end

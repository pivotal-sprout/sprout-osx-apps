if node["platform"] == "mac_os_x"
    package "gnu-tar"
    link "/usr/bin/tar" do
        to "/usr/local/bin/gtar"
    end
end


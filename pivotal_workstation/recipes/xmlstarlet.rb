if node["platform"] != "mac_os_x"
    package "xmlstarlet"
else
    package "xmlstarlet"
    link "/usr/local/bin/xmlstarlet" do
        to "/usr/local/bin/xml"
    end
end

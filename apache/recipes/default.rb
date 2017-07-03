#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

package "httpd" do
  action :remove
end

service "httpd" do 
  action [ :enable, :start ]
end
#node.default["apache"]["indexfile"] = "index2.html"

# Diabling the default apache virtual host
execute "mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled" do
 only_if do
 ::File.exist?("/etc/httpd/conf.d/welcome.conf")
 end
 notifies :restart, "service[httpd]"
end

#cookbook_file "/var/www/html/index.html" do
#  source node["apache"]["indexfile"]
#  mode "0644"
#end

# We gonna use attributes to provide the index files for each site.. 
node["apache"]["sites"].each do |site_name, site_data|
# Set the document root
  document_root = "/var/www/#{site_name}"

###############################################################################################
# Providing the configuration file for eahc of the site_name using the daynamic attributes name..
template "/etc/httpd/conf.d/#{site_name}.conf" do
 source "custom.erb"
 mode "0644"
 variables(
    :document_root => document_root,
    :port => site_data["port"]
 )
 
notifies :restart, "service[httpd]"
 end

###############################################################################################
# Document root ditectory have to be created 
directory document_root do
 mode "0755"
 recursive true
 end

###############################################################################################
# Adding index.html file for each of the domain name which is going to be configured
template "#{document_root}/index.html" do
 source "index.html.erb"
 mode "0644"
 variables(
     :site_name => site_name,
     :port => site_data["port"]
 )
 end
end

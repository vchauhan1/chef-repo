#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

template "/etc/motd" do 
  source "motd.erb"
  mode "0644"
end


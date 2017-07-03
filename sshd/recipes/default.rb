#
# Cookbook:: sshd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
cookbook_file "/etc/ssh/sshd_config" do
   source "sshd_sample"
   owner "root"
   group "root"
   mode "0600"
end

search("node","platform:centos").each do |server|
  log "The centos servers in your oraganization have the following FQDN/IP address:- #{server['fqdn']}/#{server['ipaddress']}"
end

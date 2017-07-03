name "webserver"
description "Web Server"
run_list "role[base]", "recipe[apache]"
default_attributes({
  "apache" => {
    "sites" => {
      "ponies"  => {
        "port"  => 82
        },
      "bears" => {
        "port" => 8081
        }
       }
      }
     })

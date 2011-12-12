# Note that at the moment, the URI has to be a puppet:// location
# Although hopefully future versions of puppet will let you 
# specify other locations.
define selinux::localpolicy(policy_file_name, policy_file_uri){

  # upload your selinux policy file
  file{"$policy_file_name":
    path    => "/tmp/$policy_file_name",
    source  => $policy_file_uri,
    require => Class["selinux::install"]
  }
  
  # and install it
  exec{"selinux-localpolicy-$policy_file_name":
    require => File[$policy_file_name],
    command => "/usr/sbin/semodule -i /tmp/$policy_file_name"
  }

}

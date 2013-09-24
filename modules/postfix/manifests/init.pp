class postfix ($main_template="postfix/main.cf.erb", $master_file="puppet:///modules/postfix/master.cf", $sasl_passwd_file="") {
  include postfix::params, postfix::install 
  class{'postfix::config':
     main_template      => $main_template,
     master_file        => $master_file,
     sasl_passwd_file   => $sasl_passwd_file
  }
  include postfix::service
}

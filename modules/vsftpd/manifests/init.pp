class vsftpd ($config_file="puppet:///modules/vsftpd/vsftpd.conf"){
  include vsftpd::params, vsftpd::install
  class{'vsftpd::config':
    config_file => $config_file
  }
  include vsftpd::service
}

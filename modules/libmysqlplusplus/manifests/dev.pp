class libmysqlplusplus::dev {
  require 'libmysqlplusplus'
  package {$libmysqlplusplus::params::dev_pkg_name:
    ensure => installed,
  }
}

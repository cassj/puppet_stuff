class libxml2::dev {
  require 'libxml2'
  package {$libxml2::params::dev_pkg_name:
    ensure => installed,
  }
}

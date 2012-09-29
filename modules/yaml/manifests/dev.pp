class yaml::dev {
  require 'yaml'
  package {$yaml::params::dev_pkg_name:
    ensure => installed,
  }
}

class sqlite::dev {
  require 'sqlite'
  package {$sqlite::params::dev_pkg_name:
    ensure => installed,
  }
}

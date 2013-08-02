class libgdbm::dev {
  require 'libgdbm'
  package {$libgdbm::params::dev_pkg_name:
    ensure => installed,
  }
}

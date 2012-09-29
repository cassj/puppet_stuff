class curl::dev {
  package {$curl::params::dev_pkg_name:
    ensure => installed,
  }
}

class libxslt::dev {
  include libxslt::params
  package {$libxslt::params::dev_pkg_name:
    ensure => installed,
  }
}

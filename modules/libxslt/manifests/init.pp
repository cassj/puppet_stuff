class libxslt {
  include libxslt::params
  package {$libxslt::params::pkg_name:
    ensure => installed,
  }
}

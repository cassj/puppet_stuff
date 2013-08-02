class readline {
  include readline::params
  package {$readline::params::pkg_name:
    ensure => installed,
  }
}

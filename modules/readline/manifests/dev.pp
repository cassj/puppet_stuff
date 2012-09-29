class readline::dev {
  include readline::params
  package {$readline::params::dev_pkg_name:
    ensure => installed,
  }
}

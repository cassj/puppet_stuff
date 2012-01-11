class iscsi::install{

  include iscsi::params

  package{$iscsi::params::init_pkg_name:
    ensure => present
  }

}

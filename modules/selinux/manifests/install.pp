class selinux::install{

  include selinux::params

  package{ $selinux::params::pkgs:
    ensure => present
  }

}

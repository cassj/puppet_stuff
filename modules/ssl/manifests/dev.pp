class ssl::dev{
  include ssl::params
  package {$ssl::params::dev_pkg_name:
    ensure => "installed"
  }
}

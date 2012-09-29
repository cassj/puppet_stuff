class ssl::install{
  include ssl::params
  package {$ssl::params::pkg_name:
    ensure => "installed"
  }
}

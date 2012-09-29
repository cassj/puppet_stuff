class libicu::dev {
  require 'libicu'
  package {$libicu::params::dev_pkg_name:
    ensure => installed,
  }
}

class libffi::dev {
  require 'libffi'
  package {$libffi::params::dev_pkg_name:
    ensure => installed,
  }
}

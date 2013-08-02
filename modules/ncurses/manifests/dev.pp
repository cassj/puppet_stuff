class ncurses::dev {
  include ncurses::params
  package {$ncurses::params::dev_pkg_name:
    ensure => installed,
  }
}

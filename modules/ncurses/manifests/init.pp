class ncurses {
  include ncurses::params
  package {$ncurses::params::pkg_name:
    ensure => installed,
  }
}

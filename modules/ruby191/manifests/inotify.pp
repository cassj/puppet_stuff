class ruby191::inotify {
  
  require 'ruby191','ruby191::params'
  package {$ruby191::params::inotify_pkg_name:
    ensure => installed,
  }

  
}

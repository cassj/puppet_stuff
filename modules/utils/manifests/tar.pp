# inherit from base to get resource defaults
class utils::tar inherits utils::base {

  package {'tar':
     ensure => installed 
  }

  define untar_file (
    $cwd = "",
    $require = "",
    $user = "",
    $group = "",
    $creates = "",
    $gzip_filter = false,
    $bzip_filter = false
  )
  {
    exec{$name:
      command => "tar -xf $name",
      cwd     => $cwd,
      require => $require,
      creates => $creates,
      user    => $user,
      group   => $group,
      path    => $utils::base::path
    }
  }


}

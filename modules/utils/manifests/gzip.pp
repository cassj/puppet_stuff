# Inherit from utils::base to get resource defaults
class utils::gzip inherits utils::base {
  package {'gzip':}

  define gunzip_file (
    $cwd     = "",
    $require = "",
    $user    = "",
    $creates = ""
  )
  {
    exec{$name:
      command  => "gunzip $name",
      cwd      => $cwd,
      require => $require,
      user     => $user,
      creates  => $creates
    }
  }


}

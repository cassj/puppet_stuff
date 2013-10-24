# inherit from base to get resource defaults
class utils::tar inherits utils::base {

  package {'tar':
     ensure => installed 
  }

  define untar_file (
    $file = $name,
    $cwd = "",
    $require = "",
    $user = "",
    $group = "",
    $creates = "",
    $gzip_filter = false,
    $bzip_filter = false
  )
  {
   if($gzip_filter){
     $command = "tar -xzf $file"
   }elsif($bzip_filter){
     $command = "tar -xjf $file"
   }else{
     $command = "tar -xf $file"
   }

    exec{"$cwd/$file":
      command => $command,
      cwd     => $cwd,
      require => $require,
      creates => $creates,
      user    => $user,
      group   => $group,
      path    => '/bin/'
      #path    => $utils::base::path
    }
  }


}

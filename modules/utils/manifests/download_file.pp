define utils::download_file($file=$name, $site, $cwd, $creates,$user,$group,$mode=600)
{
  include utils::base

  Exec { path => $utils::base::path}
  
   exec { "$cwd/downloadfile_$file":
    command => "wget $site/$file",
    cwd     => $cwd,
    creates => "$cwd/$file",
    user    => $user,
  }

  file { "$cwd/$file":
    owner => $user,
    group => $group,
    mode  => $mode
  }

}


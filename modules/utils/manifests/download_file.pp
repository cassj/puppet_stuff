define utils::download_file($site, $cwd, $creates,$user,$group,$mode=600)
{
  include utils::base

  Exec { path => $utils::base::path}
  
   exec { "downloadfile_$name":
    command => "wget $site/$name",
    cwd     => $cwd,
    creates => "$cwd/$name",
    user    => $user,
  }

  file { "$cwd/$name":
    owner => $user,
    group => $group,
    mode  => $mode
  }

}


define utils::zip::zip_file ($cwd,$user,$group,$creates)
{
  include utils::zip 
 
  exec {"zip_$name":
    command => "zip $creates $name",
    path    => $utils::base::path,
    cwd     => $cwd,
    user    => $user,
    group   => $group,
    creates => $creates,
  }
}


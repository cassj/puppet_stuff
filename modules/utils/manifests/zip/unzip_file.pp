define utils::zip::unzip_file ($cwd,$user,$group,$creates)
{
  include utils::zip

  exec {"unzip_$name":
    command  => "unzip $name '*' -d $creates",
    path     => $utils::base::path,
    cwd      => $cwd,
    user     => $user,
    group    => $group,
    creates  => $creates,
  }
}


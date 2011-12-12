class mysql::root_password($password, $root_password=""){

  include mysql::params

  Exec{path => $mysql::params::path }

  exec{"msql-root-password":
    unless  => "$mysql::params::cmd -uroot -p${password}",
    command => "$mysql::params::cmd -uroot --password='$root_password' -e \"update mysql.user set Password=PASSWORD('$password') where user='root'; FLUSH PRIVILEGES;\"",
    require => Class['mysql::service']
  }
}

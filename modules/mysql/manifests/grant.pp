define mysql::grant($user,$host='localhost', $password, $database, $table="*", $priv="ALL", $root_password=""){

  include mysql::params

  Exec{path => $mysql::params::path }

  exec{"mysql-grant-$user-$database-$priv-$host":
    command => "$mysql::params::cmd -uroot --password='$root_password' -e \"grant $priv on $database.$table to '$user'@'$host' identified by '$password';\"",
    require => [Mysql::User[$user], Mysql::Database[$database] ]
  }
}

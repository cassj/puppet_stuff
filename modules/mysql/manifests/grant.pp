define mysql::grant($user,$host='localhost', $database, $table="*", $priv="ALL", $root_password=""){

  include mysql::params

  Exec{path => $mysql::params::path }

  exec{"mysql-grant-$user-$database-$priv":
    command => "$mysql::params::cmd -uroot --password='$root_password' -e \"grant $priv on $database.$table to '$user'@'$host';\"",
    require => [Mysql::User[$user], Mysql::Database[$database] ]
  }
}

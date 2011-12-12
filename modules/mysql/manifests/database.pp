define mysql::database ($database=$name, $root_password="") {

  include mysql::params

  Exec{path => $mysql::params::path }

  exec{"mysql-database-$database":
    unless  => "$mysql::params::cmd -uroot --password='$root_password' -D $database",
    command => "$mysql::params::cmd -uroot --password='$root_password' -e \"create database $database;\"",
    require => Class['mysql::service']
  }
 

}

define mysql::charset ($database,$charset, $host='localhost', $root_password) {

  include mysql::params

  Exec{path => $mysql::params::path }

  exec{"mysql-charset-$database-$charset":
    command => "$mysql::params::cmd -uroot --password='$root_password' -e \"ALTER DATABASE $database CHARACTER SET $charset;\"",
    require => Mysql::Database[$database],
    unless  => "mysql -uroot -p'$root_password'  -e'SELECT default_character_set_name FROM information_schema.SCHEMATA WHERE schema_name=\"$database\"' | grep utf8"
  }

}

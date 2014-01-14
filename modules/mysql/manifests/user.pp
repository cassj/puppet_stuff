define mysql::user ($user=$name, $password, $host="localhost", $root_password = "") {

  include mysql::params

  Exec{path => $mysql::params::path }

  exec{"mysql-user-$user-$host":
    unless  => "$mysql::params::cmd -u${user} --password='${password}'",
    command => "$mysql::params::cmd -uroot --password='$root_password' -e \"create user '$user'@'$host' identified by '$password';\"",
    require => Class['mysql::service']
  }
}

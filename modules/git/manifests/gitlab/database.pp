class git::gitlab::database ($mysql_config_file, 
                          $mysql_root_pass,
                          $mysql_user,
                          $mysql_user_pass,
                          $mysql_database
){

  # Install mysql
  class{'mysql':
    configsource => $mysql_config_file
  }

  # set the mysql root password
  class {'mysql::root_password':
    password => $mysql_root_pass
  }

  # and create a DB user gitlab
  mysql::user {$mysql_user:
    user          => $mysql_user,
    password      => $mysql_user_pass,
    root_password => $mysql_root_pass,
    require => Class['mysql::root_password']
  }
  # and a gitlab database
  mysql::database{$mysql_database:
    root_password => $mysql_root_pass,
    require => Class['mysql::root_password']
  }
  #grant
  mysql::grant{'gitlab_grant':
    user          => $mysql_user,
    database      => $mysql_database,
    priv          => 'SELECT, LOCK TABLES, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER',
    root_password => $mysql_root_pass,
    require => [Mysql::User[$mysql_user], Mysql::Database[$mysql_database]]
  }



}


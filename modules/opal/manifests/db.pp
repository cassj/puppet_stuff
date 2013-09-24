class opal::db($opaldb, $opalkeydb, $dbuser, $dbpass, $mysql_root_pass){
  # create a DB user
  mysql::user {$dbuser:
    user          => $dbuser,
    password      => $dbpass,
    root_password => $mysql_root_pass
  }
  #opal db
  mysql::database{$opaldb:
    root_password => $mysql_root_pass
  }
  mysql::grant{"$dbuser-$opaldb":
    user          => $dbuser,
    database      => $opaldb,
    password      => $dbpass,
    root_password => $mysql_root_pass
  }
  #opalkey db
  mysql::database{$opalkeydb:
    root_password => $mysql_root_pass
  }
  mysql::grant{"$dbuser-$opalkeydb":
    user          => $dbuser,
    database      => $opalkeydb,
    password      => $dbpass,
    root_password => $mysql_root_pass
  }
  #set utf8 charset
  mysql::charset{"$opaldb-utf8":
    database      => $opaldb,
    charset       => 'utf8',
    root_password => $mysql_root_pass
  }
  mysql::charset{"$opalkeydb-utf8":
    database      => $opalkeydb,
    charset       => 'utf8',
    root_password => $mysql_root_pass
  }

}

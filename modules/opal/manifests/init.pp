class opal ($config, $opaldb='opal', $opalkeydb='opalkey', $dbuser, $dbpass, $mysql_root_pass){

  class{'opal::db':
    opaldb          => $opaldb,
    opalkeydb       => $opalkeydb,
    dbuser          => $dbuser,
    dbpass          => $dbpass,
    mysql_root_pass => $mysql_root_pass
  }

  include opal::install

  class{'opal::config':
    config => $config
  }
  include opal::service,opal::firewall
}

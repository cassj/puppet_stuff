class wordpress($mysql_config_source) {

  class{'mysql':
    configsource => $mysql_config_source
  }
  include apache,php,php::mysql,php::apc
  include wordpress::params

}

class wordpress($mysql_config_source) {

  class{'mysql':
    configsource => $mysql_config_source
  }
  include php,php::mysql,php::apc
  class{'apache':
    mpm_module => prefork
  }
  include apache::mod::php
  include wordpress::params

}

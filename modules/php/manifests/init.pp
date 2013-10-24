class php($configfile='puppet:///modules/php/php.ini'){

  include php::params, php::install
  class{'php::config':
    configfile => $configfile
  }

}

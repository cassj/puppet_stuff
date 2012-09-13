class mysql ($configsource){
  include mysql::params, mysql::install 
  class{'mysql::config':
         configsource => $configsource
  }
  include mysql::service
}

class postgres{

  include postgres::params, postgres::install, postgres::config, postgres::service

}

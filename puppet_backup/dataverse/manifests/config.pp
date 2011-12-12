class dataverse::config{
  
  include dataverse::params
  include postgres::params

  Exec{path => $dataverse::params::path}

# don't need this anymore - postgres setup to accept local conns with password

#  #need to edit the postgresql config file to allow local install of glassfish access
#  $string = "host all all 127.0.0.1/32 password"
#  exec{'dataverse_postgres_setting':
#    unless  => "grep '$string' $postgres::params::config_file",
#    command => "echo $string >> $postgres::params::config_file",
#    require => Package[$postgres::params::pkg] 
#  }

}

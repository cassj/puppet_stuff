# Note - this will create a dataverse at http://hostname/dvn with default
# user networkAdmin pw networkAdmin
class dataverse{  
  include dataverse::params, dataverse::install, dataverse::config, dataverse::firewall, dataverse::r
}

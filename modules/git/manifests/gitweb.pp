class git::gitweb{
  require 'my_fw'
  require 'git'

  include git::gitweb::params, git::gitweb::install
  
  

}

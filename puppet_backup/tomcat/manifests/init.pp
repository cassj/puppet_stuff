class tomcat {
  include tomcat::install, tomcat::config, tomcat::service, tomcat::firewall

}

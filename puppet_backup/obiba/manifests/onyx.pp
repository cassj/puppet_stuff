class obiba::onyx () {

  include tomcat

  $site = 'http://maven.obiba.org/maven2'
  $file = 'onyx-demo.war'

  #download the war file:
  utils::download_file {$file:
    site      => $site,
    cwd       => "$tomcat::params::catalina_home/webapps",
    creates   => "$tomcat::params::catalina_home/webapps/$file",
    user      => 'root',
    group     => 'tomcat',
    mode      => 640,
    notify    => Class['tomcat::service']
  }


}

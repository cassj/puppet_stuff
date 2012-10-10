class opal ($config){
  include opal::install
  class{'config':
    config => $config
  }
  include opal::service,opal::firewall
}

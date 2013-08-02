class aide($config="puppet:///modules/aide/aide.conf"){
  include aide::params, aide::install
  class{'aide::config':
    config => $config
  }
}

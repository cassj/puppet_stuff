class oracleexpress($config='puppet:///modules/oracleexpress/xe.rsp.example'){
  include oracleexpress::params, oracleexpress::install
  class {'oracleexpress::config':
    config => $config
  }
}

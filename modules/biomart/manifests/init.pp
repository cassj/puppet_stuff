class biomart ($version){
  class {'biomart::install':
    version => $version
  }
}

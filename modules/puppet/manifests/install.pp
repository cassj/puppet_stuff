class puppet::install {

  package {'puppet':
    ensure => latest,
  }

}

class vim{

  # don't bother for rhel flavours, is installed with core.
  case $operatingsystem {
    /(Debian|Ubuntu)/:{
      include vim::params, vim::install
    }
  }

}

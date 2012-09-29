class ruby::params {

  $pkg_name = 'ruby'
  $gems_pkg_name = 'rubygems'

  # this shouldn't really have the version hardcoded
  # maybe use facter?
  $gems_bin = '/var/lib/gems/1.8/bin'
  

}

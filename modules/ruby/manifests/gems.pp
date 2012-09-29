class ruby::gems {
  require 'ruby'

  Exec{
    path  => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin']
  }
 
  package {$ruby::params::gems_pkg_name:
    ensure => installed,
  }
  exec{'path-gems-bin':
    command => "echo 'export PATH=\$PATH:$ruby::params::gems_bin' > /etc/profile.d/ruby_gems.sh",
    creates => '/etc/profile.d/ruby_gems.sh'
  }
}

class ruby191::gems {
  require 'ruby191'

  Exec{
    path  => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin']
  }
 
  exec{'path-gems191-bin':
    command => "echo 'export PATH=\$PATH:$ruby191::params::gems_bin' > /etc/profile.d/ruby_gems.sh",
    creates => '/etc/profile.d/ruby_gems.sh'
  }

}

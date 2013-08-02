class aide::config ($config) {
   file {'/etc/aide.conf':
     source => $config,
     owner  => 'root',
     group  => 'root',
     mode   => 600
   } 
}

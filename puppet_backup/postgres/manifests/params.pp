class postgres::params{

  $path            = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

  $user   = 'postgres'
  $group  = 'postgres'
  $libdir = '/var/lib/pgsql'

  # should split this into client and server
  $pkg = ["postgresql","postgresql-server"]
  $service = "postgresql"
  $datadir = "/var/lib/pgsql/data"
  $config_file = "$datadir/pg_hba.conf"
}

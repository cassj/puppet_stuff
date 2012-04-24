class acpi::install{

  include acpi::params

  package{$acpi::params::pkg_name:
    ensure => present
  }

}

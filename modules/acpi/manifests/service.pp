class acpi::service {
  service { $acpi::params::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['acpi::install']
  }
}


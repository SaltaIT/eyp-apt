class apt::unattendedupgrades(
                              $manage_package        = true,
                              $package_ensure        = 'installed',
                              $manage_service        = true,
                              $manage_docker_service = true,
                              $service_ensure        = 'running',
                              $service_enable        = true,
                            ) inherits apt::params{
  include ::apt

  Class['::apt'] ->
  class { '::apt::unattendedupgrades::install': } ->
  class { '::apt::unattendedupgrades::config': } ->
  Class['::apt::unattendedupgrades']
}

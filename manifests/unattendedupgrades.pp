class apt::unattendedupgrades(
                              $manage_package        = true,
                              $package_ensure        = 'installed',
                            ) inherits apt::params{
  include ::apt

  Class['::apt'] ->
  class { '::apt::unattendedupgrades::install': } ->
  class { '::apt::unattendedupgrades::config': } ->
  Class['::apt::unattendedupgrades']
}

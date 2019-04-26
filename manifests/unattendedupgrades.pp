class apt::unattendedupgrades(
                              $manage_package                = true,
                              $package_ensure                = 'installed',
                              $remove_unused_dependencies    = true,
                              $install_on_shutdown           = true,
                              $auto_fix_interrupted_dpkg     = true,
                              $minimal_steps                 = true,
                              $unattended_upgrade            = true,
                              $download_upgradeable_packages = true,
                              $update_package_lists          = true,
                              $autoclean_interval            = '7',
                            ) inherits apt::params{
  include ::apt

  Class['::apt'] ->
  class { '::apt::unattendedupgrades::install': } ->
  class { '::apt::unattendedupgrades::config': } ->
  Class['::apt::unattendedupgrades']
}

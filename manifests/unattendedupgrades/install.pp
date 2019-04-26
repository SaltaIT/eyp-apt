class apt::unattendedupgrades::install inherits apt {
  if($apt::unattendedupgrades::manage_package)
  {
    package { $apt::params::unattendedupgrades_package_name:
      ensure => $apt::unattendedupgrades::package_ensure,
    }
  }
}

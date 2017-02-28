class apt::install inherits apt {

  if($apt::manage_package)
  {
    package { $apt::params::package_name:
      ensure => $apt::package_ensure,
    }
  }

}

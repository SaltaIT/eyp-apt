class apt() inherits apt::params {

  package { 'software-properties-common':
    ensure => 'installed',
  }

  exec { 'eyp-apt apt-get update':
    command     => 'apt-get update',
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
    require     => Package['software-properties-common'],
  }
}

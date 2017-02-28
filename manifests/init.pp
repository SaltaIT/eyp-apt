class apt() inherits apt::params {

  exec { 'eyp-apt apt-get update':
    command     => 'apt-get update',
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
  }
}

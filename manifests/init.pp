class apt (
            $update_cronjob  = true,
            $update_hour     = '0',
            $update_minute   = '0',
            $update_month    = undef,
            $update_monthday = undef,
            $update_weekday  = undef,
          ) inherits apt::params {

  package { 'software-properties-common':
    ensure => 'installed',
  }

  exec { 'eyp-apt apt-get update':
    command     => 'apt-get update',
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
    require     => Package['software-properties-common'],
  }

  if($update_cronjob)
  {
    $cron_ensure = 'present'
  }
  else
  {
    $cron_ensure = 'absent'
  }

  cron { 'eyp-apt update':
    ensure   => $cron_ensure,
    command  => 'apt-get update',
    user     => 'root',
    hour     => $update_hour,
    minute   => $update_minute,
    month    => $update_month,
    monthday => $update_monthday,
    weekday  => $update_weekday,
  }
}

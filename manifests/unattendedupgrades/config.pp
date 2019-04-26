class apt::unattendedupgrades::config inherits apt::unattendedupgrades {
  file { '/etc/apt/apt.conf.d/50unattended-upgrades':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/unattended-upgrades/config.erb"),
  }

  file { '/etc/apt/apt.conf.d/20auto-upgrades':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/unattended-upgrades/auto-upgrades.erb"),
  }
}

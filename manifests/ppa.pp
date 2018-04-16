#
# puppet2sitepp @aptppas
#
define apt::ppa (
                  $ensure       = 'present',
                  $package_name = $name,
                ) {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if versioncmp($::puppetversion, '4.0.0') >= 0
  {
    contain ::apt
  }
  else
  {
    include ::apt
  }

  # ppa:dontblamenrpe/ppa
  if $package_name =~ /^ppa:(.*)$/
  {
    $package_url = $1
  }
  else
  {
    fail('incorrect PPA name format')
  }

  case $ensure
  {
    'present':
    {
      exec { "ppa install ${package_name}":
        command => "add-apt-repository ${package_name}",
        unless  => "apt-cache policy | grep ${package_url}",
        notify  => Exec['eyp-apt apt-get update'],
        require => Package['software-properties-common'],
      }
    }
    default:
    {
      fail("unsupported state: ${ensure}")
    }
  }
}

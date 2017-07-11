# Package: *
# Pin: release o=LP-PPA-dontblamenrpe
# Pin-Priority: 700
#
# puppet2sitepp @aptpins
#
define apt::pin (
                  $pin_name        = $name,
                  $release         = undef, # a=
                  $codename        = undef, # n=
                  $release_version = undef, # v=
                  $component       = undef, # c=
                  $originator      = undef, # o=
                  $label           = undef, # l=
                  $package         = '*',
                  $priority        = '700',
                  $description     = undef,
                ) {

  if($release!=undef)
  {
    $release_string="a=${release} "
  }
  else
  {
    $release_string=''
  }

  if($codename!=undef)
  {
    $codename_string="n=${codename} "
  }
  else
  {
    $codename_string=''
  }

  if($release_version!=undef)
  {
    $release_version_string="v=${release_version} "
  }
  else
  {
    $release_version_string=''
  }

  if($component!=undef)
  {
    $component_string="c=${component} "
  }
  else
  {
    $component_string=''
  }

  if($originator!=undef)
  {
    $originator_string="o=${originator} "
  }
  else
  {
    $originator_string=''
  }

  if($label!=undef)
  {
    $label_string="l=${label} "
  }
  else
  {
    $label_string=''
  }

  $pin = [ $release_string, $codename_string, $release_version_string, $component_string, $originator_string, $label_string ]

  file { "/etc/apt/preferences.d/${pin_name}":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/pin.erb"),
  }
}

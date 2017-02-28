class apt::service inherits apt {

  #
  validate_bool($apt::manage_docker_service)
  validate_bool($apt::manage_service)
  validate_bool($apt::service_enable)

  validate_re($apt::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${apt::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $apt::manage_docker_service)
  {
    if($apt::manage_service)
    {
      service { $apt::params::service_name:
        ensure => $apt::service_ensure,
        enable => $apt::service_enable,
      }
    }
  }
}

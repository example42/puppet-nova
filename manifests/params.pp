# Class: nova::params
#
# Defines all the variables used in the module.
#
class nova::params {

  $extra_package_name = $::osfamily ? {
    default  => 'python-nova',
  }

  $package_name = $::osfamily ? {
    'Redhat' => 'openstack-nova-common',
    default  => 'nova-common',
  }

  $service_name = $::osfamily ? {
    default  => '',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/nova/nova.conf',
  }

  $config_file_mode = $::osfamily ? {
    default => '0640',
  }

  $config_file_owner = $::osfamily ? {
    default => 'nova',
  }

  $config_file_group = $::osfamily ? {
    default => 'nova',
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/nova',
  }

  case $::osfamily {
    'Debian','RedHat','Amazon': { }
    default: {
      fail("${::operatingsystem} not supported. Review params.pp for extending support.")
    }
  }
}

#
# = Class: nova
#
# This class installs and manages nova
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for official documentation
# on the stdmod parameters used
#
class nova (

  $conf_hash                 = undef,
  $generic_service_hash      = undef,

  $package_name              = $nova::params::package_name,
  $package_ensure            = 'present',

  $service_name              = $nova::params::service_name,
  $service_ensure            = 'running',
  $service_enable            = true,

  $config_file_path          = $nova::params::config_file_path,
  $config_file_replace       = $nova::params::config_file_replace,
  $config_file_require       = 'Package[nova]',
  $config_file_notify        = 'class_default',
  $config_file_source        = undef,
  $config_file_template      = undef,
  $config_file_content       = undef,
  $config_file_options_hash  = undef,
  $config_file_owner         = $nova::params::config_file_owner,
  $config_file_group         = $nova::params::config_file_group,
  $config_file_mode          = $nova::params::config_file_mode,

  $config_dir_path           = $nova::params::config_dir_path,
  $config_dir_source         = undef,
  $config_dir_purge          = false,
  $config_dir_recurse        = true,

  $dependency_class          = undef,
  $my_class                  = undef,

  $monitor_class             = undef,
  $monitor_options_hash      = { } ,

  $firewall_class            = undef,
  $firewall_options_hash     = { } ,

  $scope_hash_filter         = '(uptime.*|timestamp)',

  $tcp_port                  = undef,
  $udp_port                  = undef,

  ) inherits nova::params {


  # Class variables validation and management

  validate_bool($service_enable)
  validate_bool($config_dir_recurse)
  validate_bool($config_dir_purge)
  if $config_file_options_hash { validate_hash($config_file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }

  $manage_config_file_content = default_content($config_file_content, $config_file_template)

  $manage_config_file_notify  = $config_file_notify ? {
    'class_default' => 'Service[nova]',
    ''              => undef,
    default         => $config_file_notify,
  }

  if $package_ensure == 'absent' {
    $manage_service_enable = undef
    $manage_service_ensure = stopped
    $config_dir_ensure = absent
    $config_file_ensure = absent
  } else {
    $manage_service_enable = $service_enable ? {
      ''      => undef,
      'undef' => undef,
      default => $service_enable,
    }
    $manage_service_ensure = $service_ensure ? {
      ''      => undef,
      'undef' => undef,
      default => $service_ensure,
    }
    $config_dir_ensure = directory
    $config_file_ensure = present
  }


  # Resources managed

  if $nova::package_name {
    package { 'nova':
      ensure   => $nova::package_ensure,
      name     => $nova::package_name,
    }
  }

  if $nova::config_file_path {
    file { 'nova.conf':
      ensure  => $nova::config_file_ensure,
      path    => $nova::config_file_path,
      mode    => $nova::config_file_mode,
      owner   => $nova::config_file_owner,
      group   => $nova::config_file_group,
      source  => $nova::config_file_source,
      content => $nova::manage_config_file_content,
      notify  => $nova::manage_config_file_notify,
      require => $nova::config_file_require,
    }
  }

  if $nova::config_dir_source {
    file { 'nova.dir':
      ensure  => $nova::config_dir_ensure,
      path    => $nova::config_dir_path,
      source  => $nova::config_dir_source,
      recurse => $nova::config_dir_recurse,
      purge   => $nova::config_dir_purge,
      force   => $nova::config_dir_purge,
      notify  => $nova::manage_config_file_notify,
      require => $nova::config_file_require,
    }
  }

  if $nova::service_name {
    service { 'nova':
      ensure     => $nova::manage_service_ensure,
      name       => $nova::service_name,
      enable     => $nova::manage_service_enable,
    }
  }


  # Extra classes
  if $conf_hash {
    create_resources('nova::conf', $conf_hash)
  }

  if $generic_service_hash {
    create_resources('nova::generic_service', $generic_service_hash)
  }


  if $nova::dependency_class {
    include $nova::dependency_class
  }

  if $nova::my_class {
    include $nova::my_class
  }

  if $nova::monitor_class {
    class { $nova::monitor_class:
      options_hash => $nova::monitor_options_hash,
      scope_hash   => {}, # TODO: Find a good way to inject class' scope
    }
  }

  if $nova::firewall_class {
    class { $nova::firewall_class:
      options_hash => $nova::firewall_options_hash,
      scope_hash   => {},
    }
  }

}


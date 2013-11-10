# = Class: nova::example42
#
# Example42 puppi additions. To add them set:
#   my_class => 'nova::example42'
#
class nova::example42 {

  puppi::info::module { 'nova':
    packagename => $nova::package_name,
    servicename => $nova::service_name,
    processname => 'nova',
    configfile  => $nova::config_file_path,
    configdir   => $nova::config_dir_path,
    pidfile     => '/var/run/nova.pid',
    datadir     => '',
    logdir      => '/var/log/nova',
    protocol    => 'tcp',
    port        => '5000',
    description => 'What Puppet knows about nova' ,
    # run         => 'nova -V###',
  }

  puppi::log { 'nova':
    description => 'Logs of nova',
    log         => [ '/var/log/nova/api.log' , '/var/log/nova/registry.log' ],
  }

}

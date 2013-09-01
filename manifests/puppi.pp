class nova::puppi {

  # For Puppi 2 (WIP)
  $classvars=get_class_args()
  puppi::ze { 'nova':
    ensure    => $nova::manage_file,
    variables => $classvars,
    helper    => $nova::puppi_helper,
    noop      => $nova::noops,
  }

  # For Puppi 1
  puppi::info::module { 'nova':
    packagename => $nova::package,
    servicename => $nova::service,
    processname => $nova::process,
    configfile  => $nova::config_file,
    configdir   => $nova::config_dir,
    pidfile     => $nova::pid_file,
    datadir     => $nova::data_dir,
    logdir      => $nova::log_dir,
    protocol    => $nova::protocol,
    port        => $nova::port,
    description => 'What Puppet knows about nova',
    # run         => 'nova -V###',
  }

  puppi::log { 'nova':
    description => 'Logs of nova',
    log         => $nova::log_file,
  }

}

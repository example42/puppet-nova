# Class: nova::params
#
# This class defines default parameters used by the main module class nova
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to nova class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class nova::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'nova',
  }

  $service = $::operatingsystem ? {
    default => 'nova',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'nova',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'nova',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/nova',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/nova/nova.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/nova',
    default                   => '/etc/sysconfig/nova',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/nova.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/nova',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/nova',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/nova/nova.log',
  }

  $port = '42'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}

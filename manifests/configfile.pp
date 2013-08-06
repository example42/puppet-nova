#
# = Define: nova::configfile
#
# The define manages nova configfile
#
#
# == Parameters
#
# [*ensure*]
#   String. Default: present
#   Manages configfile presence. Possible values:
#   * 'present' - Install package, ensure files are present.
#   * 'absent' - Stop service and remove package and managed files
#
# [*template*]
#   String. Default: Provided by the module.
#   Sets the path of a custom template to use as content of configfile
#   If defined, configfile file has: content => content("$template")
#   Example: template => 'site/configfile.conf.erb',
#
# [*options*]
#   Hash. Default undef. Needs: 'template'.
#   An hash of custom options to be used in templates to manage any key pairs of
#   arbitrary settings.
#
define nova::configfile (
  $template ,
  $ensure   = present,
  $options  = '' ,
  $ensure  = present ) {

  include nova

  file { "nova_configfile_${name}":
    ensure  => $ensure,
    path    => "${nova::config_dir}/${name}",
    mode    => $nova::config_file_mode,
    owner   => $nova::config_file_owner,
    group   => $nova::config_file_group,
    require => Package[$nova::package],
    notify  => $nova::manage_registry_service_autorestart,
    content => template($template),
    replace => $nova::manage_file_replace,
    audit   => $nova::manage_audit,
    noop    => $nova::bool_noops,
  }

}

#nova

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Resources managed by nova module](#resources-managed-by-nova-module)
    * [Setup requirements](#setup-requirements)
    * [Beginning with module nova](#beginning-with-module-nova)
4. [Usage](#usage)
5. [Operating Systems Support](#operating-systems-support)
6. [Development](#development)

##Overview

This module installs, manages and configures nova and its services.

##Module Description

The module is based on **stdmod** naming standards version 0.9.0.

Refer to [http://github.com/stdmod/](http://github.com/stdmod/) for complete documentation on the common parameters.

For a fully automated Puppet setup of OpenStack you'd better use the official [StackForge modules](https://github.com/stackforge/puppet-openstack).
This module is intended to be a quick replacement for setups where you want to manage configurations based on plain template files or where you want to puppettize an existing OpenStack installation.

##Setup

###Resources managed by nova module
* This module installs the nova package (in case of multiple services, the nova-api package is installed)
* Enables the nova service (in case of multiple services, the nova-api service is managed)
* Can manage all the configuration files (by default no file is changed)
* Can manage any nova service and its configuration file (by default no file is changed)

###Setup Requirements
* PuppetLabs [stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)
* StdMod [stdmod module](https://github.com/stdmod/stdmod)
* Puppet version >= 2.7.x
* Facter version >= 1.6.2

###Beginning with module nova

To install the package provided by the module just include it:

        include nova

The main class arguments can be provided either via Hiera (from Puppet 3.x) or direct parameters:

        class { 'nova':
          parameter => value,
        }

The module provides a generic define to manage any nova configuration file in /etc/nova:

        nova::conf { 'sample.conf':
          content => '# Test',
        }

A define to manage the package/service/configfile of single nova services. To install the package and run the service:

        nova::generic_service { 'nova-registry': }

To provide a configuration file for the service (alternative to nova::conf):

        nova::generic_service { 'nova-registry':
          config_file_template => 'site/nova/nova-registry.conf
        }

##Usage

* A common way to use this module involves the management of the main configuration file via a custom template (provided in a custom site module):

        class { 'nova':
          config_file_template => 'site/nova/nova.conf.erb',
        }

* You can write custom templates that use setting provided but the config_file_options_hash paramenter

        class { 'nova':
          config_file_template      => 'site/nova/nova.conf.erb',
          config_file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }

* Use custom source (here an array) for main configuration file. Note that template and source arguments are alternative.

        class { 'nova':
          config_file_source => [ "puppet:///modules/site/nova/nova.conf-${hostname}" ,
                                  "puppet:///modules/site/nova/nova.conf" ],
        }


* Recurse from a custom source directory for the whole configuration directory (/etc/nova).

        class { 'nova':
          config_dir_source  => 'puppet:///modules/site/nova/conf/',
        }

* Use custom source directory for the whole configuration directory and purge all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'nova':
          config_dir_source => 'puppet:///modules/site/nova/conf/',
          config_dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'nova':
          config_dir_source    => 'puppet:///modules/site/nova/conf/',
          config_dir_recursion => false, # Default: true.
        }

* Do not trigger a service restart when a config file changes.

        class { 'nova':
          config_dir_notify => '', # Default: Service[nova]
        }

##Operating Systems Support

This is tested on these OS:
- RedHat osfamily 6
- Ubuntu 12.04


##Development

Pull requests (PR) and bug reports via GitHub are welcomed.

When submitting PR please follow these quidelines:
- Provide puppet-lint compliant code
- If possible provide rspec tests
- Follow the module style and stdmod naming standards

When submitting bug report please include or link:
- The Puppet code that triggers the error
- The output of facter on the system where you try it
- All the relevant error logs
- Any other information useful to undestand the context

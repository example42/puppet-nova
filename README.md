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

This module installs, manages and configures nova.

##Module Description

The module is based on **stdmod** naming standards version 0.9.0.

Refer to http://github.com/stdmod/ for complete documentation on the common parameters.

For a fully puppetized OpenStack implementation you'd better use the official StackForge modules. This module is intended to be a quick replacement for setups where you want to manage configurations based on plain files on an existing setup.


##Setup

###Resources managed by nova module
* This module installs the nova package
* Enables the nova-api and nova-registry services
* Can manage all the configuration files (by default no file is changed)

###Setup Requirements
* PuppetLabs stdlib module
* StdMod stdmod module
* Puppet version >= 2.7.x
* Facter version >= 1.6.2

###Beginning with module nova

To install the package provided by the module just include it:

        include nova

The main class arguments can be provided either via Hiera (from Puppet 3.x) or direct parameters:

        class { 'nova':
          parameter => value,
        }

The module provides also a generic define to manage any nova configuration file:

        nova::conf { 'sample.conf':
          content => '# Test',
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


* Use custom source directory for the whole configuration directory, where present.

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


* Install extra packages (clients, plugins...). Can be an array. Default: client package.

        class { 'nova':
          extra_package_name    => [ 'python-nova' , 'python-novaclient' ],
        }


* Use the additional example42 subclass for puppi extensions

        class { 'nova':
          my_class => 'nova::example42'
        }

##Operating Systems Support

This is tested on these OS:
- RedHat osfamily 5 and 6
- Debian 6 and 7
- Ubuntu 10.04 and 12.04


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


# == Class: mediawiki
#
# Full description of class mediawiki here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'mediawiki':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
ass mediawiki {



  $phpmysql = $osfamily ? {

    'redhat' => 'php-mysql',

    'debian' => 'php5-mysql',

    default => 'php-mysql', 

  }



  package { $phpmysql:

    ensure => 'present',

  }



  if $osfamily == 'redhat' {

    package { 'php-xml':

      ensure => 'present',

  }

 }



  class { '::apache':

    docroot    => '/var/www/html',

    mpm_module => 'prefork',

    subscribe  => Package[$phpmysql],

 }



  class { '::apache::mod::php':}



  vcsrepo { '/var/www/html':

    ensure   => 'present',

    provider => 'git',

    source   => "https://github.com/wikimedia/mediawiki.git",

    revision => 'REL1_23',

 }



  file { '/var/www/html/index.html':

     ensure  => 'absent',

 }



  File['/var/www/html/index.html'] -> Vcsrepo['/var/www/html']



  class { '::mysql::server':

   root_password => 'training',

 }



  class { '::firewall': }

  

  firewall { '000 allow http access':

    port   => '80',

    proto  => 'tcp',

    action => 'accept',

 }


file { 'LocalSettings.php':

   path  => '/var/www/html/LocalSettings.php',

   ensure => 'file',

   content => template('mediawiki/LocalSettings.erb'),

 }
   

  class { '::tomcat': }



  tomcat::install { '/opt/tomcat':

    source_url => 'https://www.apache.org/dist/tomcat/tomcat-7/v7.0.70/bin/apache-tomcat-7.0.70.tar.gz'

 }

  tomcat::instance { 'default':

    catalina_home => '/opt/tomcat',





 }

tomcat::config::server::connector { 'tomcat-http':

  catalina_base         => '/opt/tomcat',

  port                  => '8081',

  protocol              => 'HTTP/1.1',

  additional_attributes => {

    'redirectPort' => '8443'

  },

}

class { 'java': }

class { 'sonarqube' :

  version => '5.1',

}

 }

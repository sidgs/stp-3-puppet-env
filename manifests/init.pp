
class mediawiki {



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

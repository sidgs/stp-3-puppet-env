
node 'tomcat-server-1', "puppetagent*"  {
  class {'linux':}
  # install package
  # CATALINA_HOME
  tomcat::install {'/opt/tomcat8' :
    source_url => 'http://apache.osuosl.org/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz',
  }
  # Instance Identifier
  tomcat::instance {'default' :
    catalina_home => '/opt/tomcat8',
  }
  # Shutdown Port
  tomcat::config::server { 'default' :
    catalina_base => '/opt/tomcat8',
    port => '8006',
  }
  tomcat::config::server::connector {'default' :
    catalina_base => '/opt/tomcat8',
    port          => '8081',
    protocol      => 'HTTP/1.1',
    additional_attributes => {
      'redirectPort' => '8443',
    }
  }
  # setup service , ensure that it is running
#  tomcat::service { 'default' :
#      service_enable => true,
#      service_ensure => 'running',
#  }
  # deploy the project 'petclinic'
}

node 'jenkins' {
  class {'linux':}
}

node 'database' {

  class {'linux':}
}

node 'puppetmaster' {

  class {'linux':}
}

node 'sonarqube' {

  class {'linux':}
}

node 'webserver' {

  class {'linux':}

}

# these are the set of foundational services
class linux {
  $admintools = ['git','nano','screen']
  package { $admintools:
    ensure => 'installed',
  }

  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
     default => 'ntp',
  }

  package { $ntpservice:
    ensure => 'installed',
  }
  service { $ntpservice:
    ensure =>  'running',
    enable => true,
  }

}



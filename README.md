# stp-3-puppet-env

This module provides the configuration required to setup and maintain the Devops stack as well as 
enable contineous deployment into the development area.

Different Services that are managed in this module are 
  1. Webserver -Apache
  2. Application Server - Tomcat
  3. Database Server - MySQL
  4. SonarQube
  5. Firewall Service
  6. Maven


Installation Instructions:
  
  Puppetmaster:
  
  a. Prerequsites:
    1. 64-bit Linux machine 2 core, 4 GB 60GB disk for puppetmaster
    2. ssh access
    3. Allow incoming access to port 8140
    4. Sudo access 
    5. Setup apache,passenger
    6. Git access
  
  b. Installation:
    1. Install and config Puppetmaster
    2. git clone this repo to '/etc/puppet/environments/'
    3. Rename the directory to Dev
    

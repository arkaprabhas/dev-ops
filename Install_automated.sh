#!/bin/bash
echo "THis script will search for APACHE , HAPROXY or JENKINS and install it in your system .."
echo "Prereq: Your server must be connected to the internet .."

function Install_apache 
{
  echo "Searching and Installing apache .."
  yum search apache > /dev/null
}

function Install_haproxy 
{
  echo "Searching and Installing apache .."
  yum search haproxy > /dev/null
}

function Install_jenkins 
{
echo  "Checking for Java updates , Or installting as is ..."
echo "Checking java version ..."
java -version
echo "checking java updates or installing java ..." 
yum search java-1.8.0-openjdk > /dev/null
`echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile`
`echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile`
source /etc/profile > /dev/null
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum install jenkins
systemctl start jenkins.service
systemctl enable jenkins.service
firewall-cmd --zone=public --permanent --add-port=8080/tcp
firewall-cmd --reload
}

echo "Do you want to Install Apache Haproxy Jenkins Apache & Haproxy Jenkins|All : Apache Haproxy Jenkins Apache & Haproxy Jenkins All "
read R

case $R in
 [aA][pP][aA][cC][hH][eE])
  echo "Searching and Installing apache .."
  Install_apache
  ;;

  [hH][aA][pP][rR][oO][xX][yY])
   echo "Searching and Installing HaProxy .."
   Install_haproxy
  ;;

  [jJ][eE][nN][kK][iI][nN][sS])
  echo "Searching and Installing Jenkins .."
  Install_jenkins
  ;;

  [aA][lL][lL])
  echo "Searching and Installing apache,HaProxy,Jenkins .."
  Install_apache
  Install_haproxy
  Install_jenkins
  ;;

  *)
  echo "Bad choice buddy ... ;)"
  ;;
esac


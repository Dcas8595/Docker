#!/bin/bash

# Run updates and install wget + nano
yum -y update
yum install -y wget nano

# Download, install and configure java 
cd /opt
wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz
tar -zxvf jdk-8u121-linux-x64.tar.gz
rm -f jdk-8u121-linux-x64.tar.gz
update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_121/bin/java 100
update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_121/bin/javac 100

# Download, install and configure Maven
cd /opt
wget wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -zxvf apache-maven-3.3.9-bin.tar.gz
rm -f apache-maven-3.3.9-bin.tar.gz
#ln -s apache-maven-3.3.9 maven
echo 'export M2_HOME=/opt/apache/maven' >> /etc/profile.d/maven.sh
echo 'PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mkdir -m 777 /opt/apache/apache-maven-3.2.2/maven-repo
mvn --version

# Download mule standalone tarball from the Mulesoft repository and checksum its contents
cd /opt
wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.8.1/mule-standalone-3.8.1.tar.gz
echo 'd28c6358b5e1a3e131d78d5eb1d2b5aadb079c0fc01c534d443277cfe96ab252' mule-standalone-3.8.1.tar.gz  | md5sum -c

# Extract and remove the tarball 
tar -xzvf mule-standalone-3.8.1.tar.gz
rm -f mule-standalone-3.8.1.tar.gz
#ln -s mule-standalone-3.8.1 mule

# Setting the Path Variables
echo -e '\nexport JAVA_HOME="/opt/jdk1.8.0_121"' >> ~/.bashrc
echo 'export MAVEN_HOME="/opt/apache-maven-3.3.9"' >> ~/.bashrc
echo 'export M2_HOME="/opt/apache-maven-3.3.9"' >> ~/.bashrc
echo 'export MULE_HOME="/opt/mule-standalone-3.8.1"' >> ~/.bashrc
echo 'export PATH="$PATH:$JAVA_HOME:$M2_HOME/bin:$MULE_HOME/bin"' >> ~/.bashrc

# Run the Container
# sudo docker run -p 8081:8081 mule-image:3.8.1

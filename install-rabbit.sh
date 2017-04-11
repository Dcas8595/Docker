#!/bin/bash

# Run updates and install wget
yum -y update
yum install -y wget epel-release
reboot

# Install erlang
cd /opt
wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
yum install -y erlang

# Install RabbitMQ
wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-3.6.9-1.el7.noarch.rpm
rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
yum install -y rabbitmq-server-3.6.9-1.el7.noarch.rpm

# Enable RabbitMQ management plugin
/sbin/rabbitmq-plugins enable rabbitmq_management

# Run the container
# sudo docker run rabbit-image:3.6.9 &

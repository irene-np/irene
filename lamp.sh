#!/bin/bash
# Actualizamos los repositorios
apt-get update

#Instalamos apache
apt-get install apache2 -y

# Instalamos paquetes para apache
apt-get install php libapache2-mod-php php-mysql -y

#Instalamos adminer
cd /var/www/html
mkdir adminer
cd adminer
wget https://github.com/vrana/adminer/releases/download/v4.7.3/adminer-4.7.3-mysql.php
mv adminer-4.7.3-mysql.php index.php

# Instalamos defconf-utilss -y
apt-get install debconf-utils -y

# Configuramos la contraseña mysql
debconf-set-selections <<< "mysql-sever mysql-server/root_password password $DB_ROOT_PASSWD=root"
debconf-set-selections <<< "mysql-sever mysql-server/root_password_again password $DB_ROOT_PASSWD=root"
 
# Instalar mysql
apt-get install mysql-server -y

# Instalamos git
apt-get install git

cd /var/www/html
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git
chown www-data:www-data iaw-irene-lamp/ -R

# Configuramos la aplicacion web
DB_NAME=lamp_db
DB_USER=lamp_user
DB_PASSWD=lamp_user
mysql -u root -p$DB_ROOT_PASSWD <<< ""
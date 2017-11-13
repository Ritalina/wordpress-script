#!/bin/bash
sudo apt-get update
#Instalacion de apache
sudo apt-get install apache2 -y
#Instalacion de MYSQL
sudo debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password 'rita'" && sudo debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password 'rita'"
sudo apt-get install mysql-server -y
#Instalacion de PHP para MYSQL
sudo apt-get install php libapache2-mod-php -y php-mcrypt -y php-mysql -y
sudo apt-get install php-cli -y
#Cambio de archivos en directorio
sudo rm /etc/apache2/mods-enabled/dir.conf
sudo cp /home/rita/dir.conf /etc/apache2/mods-enable/
sudo chmod 1777 /etc/apache2/mods-enable/dir.conf
sudo service apache2 restart
sudo service apache2 start
#Crear base de datos MYSQL
mysql -u root -prita -e "CREATE DATABASE wordpress; CREATE USER wordpressuser@localhost IDENTIFIED BY 'password'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost; FLUSH PRIVILEGES;"
#Descargar wordpress
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
sudo apt-get update
#Configurar wordpress
cd ~/wordpress
sudo cp /home/rita/wp-config.php ~/wordpress/
sudo chmod 1777 ~/wordpress/wp-config.php
#Copiar archivos a la raiz del servidor
sudo cp -r ~/wordpress/* /var/www/html/
cd /var/www/html
sudo chown -R rita:www-data *
mkdir /var/www/html/wp-content/uploads
sudo chown -R :www-data /var/www/html/wp-content/uploads
exit

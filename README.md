# irene

# Tener la maquina virtual ubuntu en funcionamiento
- Estar conectado en la red de clase (Rango).
- Tener internet (ping 8.8.8.8).
- Abrir la terminar.

# Crear cuenta de Github
## URL de mi repositorio
```
https://github.com/irene-np/irene
```

# Lamp stack

- sudo apt-get update.
- sudo apt-get upgrade.

# 1. Instalar SSH

```
sudo apt-get install ssh
```

# Arrancar el SSH y ver estado

```
sudo systemctl start ssh
sudo systemctl status ssh
```
# 2. Instalar apache2

```
sudo apt-get install apache2
```
# Arrancar el apache2 y ver estado

```
sudo systemctl start apache2
sudo systemctl status apache2
```

# Comprobar si el apache funciona

```
http://tu-ip
```
# 3. Instalar PHP

```
sudo apt-get install php
```
# Instalar paquete

```
sudo apt-get install libapache2-mod-php
```
# Instalar php - mysql

```
sudo apt-get install php-mysql
```
# Ir directorio html

```
cd /var/www/html/
```

# crear archivo info.php

```
sudo nano info.php
```
# Archivo info.php

```
<?php
phpinfo();
?>
```
# Comprobar que funcina

```
http://tu-ip/info.php
```
# 4. Instalar Mysql

```
sudo apt-get install mysql-server
```
# Arracar el mysql y ver estado

```
sudo systemctl start mysql
sudo systemctl status mysql
```
# Comandos utilizados mysql

```
su -superusuario
show databases; - ver las bases de datos
user mysql; - usuarios mysql
select user,host,plugin from user; - ver usuario y equipos
```
# 5. Instalar git

```
sudo apt-get install git
```
# 6. Instalar phpmyadmin
```
sudo apt-get install phpmyadmin
```
# Pasos
- elegir apache2.
- Configurar base de datos.
- Contraseña.
- Confirmar contraseña.

# Comprobar acceso
```
http://tu-ip/phpmyadmin
```
# 7. Instalar Adminer - Mysql
## Pasos

- cd /var/www/html/ - cambiar de Directorio
- sudo mkdir adminer - crear el directorio adminer
- cd adminer - cabiar al directorio adminer
- sudo wget https://github.com/vrana/adminer/releases/download/v4.7.3/adminer-4.7.3-mysql.php - descargar adminer en github
- sudo mv adminer-4.7.3-mysql.php index.php - moverlo a index.php

# 8. Instalar GoAccess
## Pasos
```
- echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list
- wget -O - https://deb.goaccess.io/gnugpg.key | sudo apt-key add - (es una o mayuscula)
- sudo apt-get update
- sudo apt-get install goaccess
```
## Comando para analizar el archivo log (access.log) y muestra información
```
goaccess /var/log/apache2/access.log -c
```
## Creación de un archivo HTML estático
```
sudo goaccess /var/log/apache2/access.log -o /var/www/html/report.html --log-format=COMBINED
```
## Creación de un archivo HTML en tiempo real
```
goaccess /var/log/apache2/access.log -o /var/www/html/report.html --log-format=COMBINED --real-time-html
```
# 9. Control de acceso a un directorio con .htaccess 
## Pasos
```
- cd /var/www/html (Para cambiar al directorio /var/www/html)

- sudo mkdir stats (crear directorio stats)

- sudo goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html & (Lanzamos el proceso para generar informes)


- sudo htpasswd -c /home/usuario/.htpasswd usuario (Creamos archivo de contraseñas para el usuario que elijamos dentro de /home/usuario, donde usuario va el nuestro)

- sudo nano /var/www/html/stats/.htaccess (Creamos archivo .htaccess en el directorio /var/www/html/stats)

```
### Contenido .htaccess
````
AuthType Basic
AuthName "Restricted Content"
AuthUserFile /home/usuario/.htpasswd (usuario=tu usuario)
Require valid-user
````
```
- sudo nano /etc/apache2/sites-enabled/000-default.conf (Editamos archivo de configuación de Apache)

```
### Contenido apache
```
Añadimos dentro de <VirtualHost *:80> y </VirtualHost>.
```
```
<Directory "/var/www/html/stats">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
```
```
- sudo /etc/init.d/apache2 restart (Reiniciamos apache2)
```
#Actualizar repositorios e instalar Nginx
sudo apt update
sudo apt install -y nginx 


#instalar vsftpd
sudo apt-get upgrade -y
sudo apt-get install -y vsftpd
sudo apt-get install -y git

#Comprobamos que nginx se ha instalado y que está funcionando correctamente:
systemctl status nginx

#Crear la carpeta para la página web
sudo mkdir -p /var/www/pagina_web/html


#Clonar el repositorio de la página web en la carpetaa

sudo git clone https://github.com/cloudacademy/static-website-example /var/www/pagina_web/html

#Asignar permisos correspondientes
sudo chown -R www-data:www-data /var/www/
sudo chmod -R 775 /var/www/



#Crear el archivo de configuracion de la pagina web en /etc/nginx/sites-available

sudo bash -c 'cat > /etc/nginx/sites-available/pagina_web <<EOF
server {
    listen 80;
    listen [::]:80;
    root /var/www/pagina_web/html;
    index index.html index.htm index.nginx-debian.html;
    server_name www.david.test;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'

sudo cp /etc/nginx/sites-available/pagina_web  /vagrant


#Crear enlace simbolico en /etc/nginx/sites-enabled

sudo ln -s /etc/nginx/sites-available/pagina_web /etc/nginx/sites-enabled

#Reiniciar el servicio de Nginx
sudo systemctl restart nginx



#Volveremos a hacer los mismo pasos para tener otra pagina con el mismo dominio pero esta vez metiendo los archivos con FIllezilla

#Para ello creamos una nueva carpeta para la pagina web

sudo mkdir -p /var/www/kaze/html

#Nos aseguramos de que los permisos sean correctos 

sudo chown -R www-data:www-data /var/www/kaze/html
sudo chmod -R 775 /var/www/kaze


#Creamos el archivo de configuracion para la nueva pagina

sudo bash -c 'cat > /etc/nginx/sites-available/kaze <<EOF
server {
    listen 80;
    listen [::]:80;
    root /var/www/kaze/html;
    index index.html index.htm index.nginx-debian.html;
    server_name www.kaze.test;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'
sudo cp /etc/nginx/sites-available/kaze  /vagrant

#Creamos el archivo simbolico en /etc/nginx/sites-enabled

sudo ln -s /etc/nginx/sites-available/kaze /etc/nginx/sites-enabled

#Reiniciar el servicio de Nginx
sudo systemctl restart nginx


sudo apt-get update

#Creamos un usuario 

sudo adduser david
echo "david:david" | sudo chpasswd


# Agregamos el usuario  al grupo www-data
sudo usermod -aG www-data david

#Crear la carpeta para el servidor FTP

sudo mkdir /home/david/ftp

sudo chown david:david /home/david/ftp
sudo chmod 775 /home/david/ftp

sudo chown david:www-data /home/david/ftp


# #Copiamos certificados de seguridad 

# sudo cp /vagrant/vsftpd.crt  /etc/ssl/certs/vsftpd.crt 

# sudo cp /vagrant/vsftpd.key  /etc/ssl/private/vsftpd.key

# #Editar el archivo de configuracion vsftpd
# sudo cp /vagrant/vsftpd.conf /etc/vsftpd.conf


# #Reiniciar el servicio vsftpd
# sudo systemctl restart vsftpd
# sudo systemctl restart nginx


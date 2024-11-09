#Actualizar repositorios e instalar Nginx
sudo apt update
sudo apt install -y nginx git vsftpd

#Comprobamos que nginx se ha instalado y que está funcionando correctamente:
systemctl status nginx

#Crear la carpeta para la página web
sudo mkdir -p /var/www/pagina_web/html


#Clonar el repositorio de la página web en la carpetaa

sudo git clone https://github.com/cloudacademy/static-website-example /var/www/miweb/html

#Asignar permisos correspondientes
sudo chown -R www-data:www-data /var/www/pagina_web/html
sudo chmod -R 755 /var/www/pagina_web

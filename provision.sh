#Actualizar repositorios e instalar Nginx
sudo apt update
sudo apt install -y nginx git vsftpd

#Comprobamos que nginx se ha instalado y que está funcionando correctamente:
systemctl status nginx

#Crear la carpeta para la página web
sudo mkdir -p /var/www/pagina_web/html


#Clonar el repositorio de la página web en la carpetaa

sudo git clone https://github.com/cloudacademy/static-website-example /var/www/pagina_web/html

#Asignar permisos correspondientes
sudo chown -R www-data:www-data /var/www/pagina_web/html
sudo chmod -R 755 /var/www/pagina_web
sudo chmod 755 /var/www/pagina_web



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

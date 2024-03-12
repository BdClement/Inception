# Tout cela sera fait a partir de notre container construit sur debian bullseye
# Le container est build puis dedans on fait toute les configs necessaire (ce qui est fait dans le dockerfile)
FROM debian:bullseye

RUN apt update && apt upgrade
RUN apt install vim -y
RUN apt install curl -y
RUN apt install nginx -y
# Dossier pour stocker le certificat et la clef pour une connexion securisee (TSL)
RUN mkdir -p /etc/nginx/ssl
# Installation de l'outilprincipal pour la gestion/creation de certificat SSP (OpenSSL)
RUN apt install openssl -y
# req permet de creer un certicat au format x509 .
# -nodes permet d'eviter la demande de mot de passe lors de la creation du certificat
# -out pour ou se trouvera le certificat et -keyout ou se trouvera la clef
#RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=clbernar.42.fr/UID=clbernar"
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=clbernar.42.fr/UID=clbernar"
# Creation d'un dossier pour sotcker pour stocker les fichiers de config de NGINX
RUN mkdir -p /var/run/nginx

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

#Copie du fichier de configuration initial de ngninx
COPY conf/nginx.conf /etc/nginx/nginx.conf
#COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

# Lancement de NGINX en premier plan pour que le container ne se stoppe pas
CMD [ "nginx", "-g", "daemon off;" ]

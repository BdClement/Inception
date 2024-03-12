
service mariadb start;

#La variable d'env SQL_DATABASE doit etre ajoute au .env
#Je demande de creer une table si elle n'existe pas du nom de ${SQL_DATABASE}
#mysql -e "CREATE DATABASE selem;"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;'"
#Je cree l'utilisateur SQL_USER s'il n'existe pas, avec le SQL_PASSWORD toujours
#a indiquer a .env
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
#Je donne les droits a l'utilisateur SQL_USER avec le mot de pass SQL_PASSWORD indique dans le .env
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
#Je change les droits de mon utilisateur root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
#Je rafraichis pour que mysql prenne tout en compte
mysql -e "FLUSH PRIVILEGES;"
#Redemarrage de mysql
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe


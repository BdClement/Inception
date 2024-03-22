#Start le service mariadb
service mariadb start;

#Creation d'une table si elle n'existe pas du nom de ${SQL_DATABASE}
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

#Creation d'un utilisateur s'i n'existe pas deja avec son mot de passe associe
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

#Je donne tout les droits sur la DB a l'utisateur que je viens de creer 
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

#Je change le mot de passe de l'utilisateur root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#Je rafraichis pour que mysql prenne tout en compte
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

#Redemarrage de mysql
mysqladmin -p"${SQL_ROOT_PASSWORD}" shutdown
exec mysqld_safe


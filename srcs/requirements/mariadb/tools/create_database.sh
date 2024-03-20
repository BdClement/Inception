#Start le service mariadb
service mariadb start;

#Les variables d'env doivent etre ajoutees au .env
#echo " $SQL_DATABASE    C'est un test";
#Creation d'une table si elle n'existe pas du nom de ${SQL_DATABASE}
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
#mysql -e "CREATE DATABASE IF NOT EXISTS TestDB;" #TEST V

#Creation d'un utilisateur s'i n'existe pas deja avec son mot de passe associe
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "CREATE USER IF NOT EXISTS CLB@'localhost' IDENTIFIED BY 'IncCLBPassWord24';"
#mysql -e "Show Databases;"

#Je donne les tout les droits a l'utilisateur que je viens de creer sur la DB
#mysql -e " GRANT ALL PRIVILEGES ON TestDB.* TO CLB@'%' IDENTIFIED BY 'IncCLBPassWord24';"
#mysql -e " GRANT ALL PRIVILEGES ON TestDB.* TO CLB@'localhost' IDENTIFIED BY 'IncCLBPassWord24';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

#Je change le mot de passe de l'utilisateur root
#mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'IncPassWord24';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#Je rafraichis pour que mysql prenne tout en compte
#mysql -e "SHOW GRANTS FOR 'root'@'localhost';"
#L'erreur est que j'ai set un mot de passe a root et que je dois me connecteren tant que root pour faire FLUSH PRIVILEGES
#mysql -u root -p'IncPassWord24' -e "FLUSH PRIVILEGES;"
mysql -u root -p"$SQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
#mysql -e "FLUSH PRIVILEGES;"

#Redemarrage de mysql
#mysqladmin -p'IncPassWord24' shutdown
mysqladmin -p"${SQL_ROOT_PASSWORD}" shutdown
#mysqladmin -u root -p'IncPassWord24' shutdown
#mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdow
exec mysqld_safe


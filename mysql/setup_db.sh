
#TODO: make the starting of mysql configurable, someone that runs this container
# may want to point to a db.
service mysql start

mysql -uroot -ppassword -h localhost -e "create database sakai default character set utf8;"
mysql -uroot -ppassword -h localhost -e "grant all privileges on sakai.* to 'sakai'@'localhost' identified by 'ironchef';"
mysql -uroot -ppassword -h localhost -e "grant all privileges on sakai.* to 'sakai'@'127.0.0.1' identified by 'ironchef';"

@echo off
echo "starting..."

set DB_USER=root
set DB_HOST=localhost
set NEW_DB=databaseproject

rem Execute SQL script
mysql -u "%DB_USER%"  -h "%DB_HOST%" < "C:/Users/Hp/Desktop/db_home_work/project.sql"

echo "done ^_^"
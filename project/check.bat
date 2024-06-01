@echo off
echo Hello!
echo "Running All Processes ..."

rem Database connection details
set DB_USER=root
set DB_HOST=localhost
set NEW_DB=db

rem Execute SQL script
mysql -u "%DB_USER%" -h "%DB_HOST%" < "C:\\Users\\Hp\\Desktop\\chaza_jana\\extract.sql"

echo "data extracted into csv file"
Oracle XE 21c

Downloading the image and configuring a new db with docker:

docker run -d --name oracle-xe -p 1521:1521 -e ORACLE_PWD=Oracle123 container-registry.oracle.com/database/express:21.3.0-xe

• -d -> background
• --name -> container name
• -p 1521:1521 -> host/container
• -e ORACLE_PWD -> password from system

How to connect:

docker exec -it oracle-xe sqlplus system/Oracle123@//localhost:1521/XEPDB1

SQL Server 2022

Downloading the image

docker run -d --name sql-server -p 1433:1433  -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=SqlServer123!" mcr.microsoft.com/mssql/server:2022-latest

ACCEPT_EULA=Y -> mandatory
MSSQL_SA_PASSWORD -> System Adm password

How to connect:

docker exect -it sql-server /opt/msqql-tools18/bin/sqlcmd -S localhost -U sa -P 'SqlServer123!' -C

• -c -> Accept the self-signed cert
• GO - execute the command 


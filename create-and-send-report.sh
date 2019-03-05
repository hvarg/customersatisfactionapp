#!/bin/bash

address=hvargasl@interior.gob.cl
subject="Reporte mensual satisfaccion de usuarios"
body="Se adjuntan los datos de satisfaccion de usuario correspondientes al mes anterior."
dbname=customersatisfactionapp_development
query="COPY (SELECT created_at, score FROM surveys WHERE created_at > now() - interval '1' month) TO STDOUT WITH CSV DELIMITER ',';"
filename=/home/ec2-user/customersatisfactionapp/reports/$(date +%m-%y.csv -d 'last month')

echo $query | psql -o $filename $dbname
echo $body | mailx -A gmail -s "$subject" -a $filename $address
#The 'gmail' account must be configured in ~/.mailrc

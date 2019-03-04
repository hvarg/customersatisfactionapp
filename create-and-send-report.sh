#!/bin/bash

filename=reports/$(date +%m-%y.csv -d 'last month')
echo "COPY (SELECT created_at, score FROM surveys WHERE created_at > now() - interval '1' month) TO STDOUT WITH CSV DELIMITER ',';" | psql -o $filename customersatisfactionapp_development
cat reports/mail_cont.txt | mailx -A gmail -s "Reporte mensual satisfaccion de usuarios" -a $filename mail@gmail.com

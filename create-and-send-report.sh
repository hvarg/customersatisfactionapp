filename=reports/$(date +%m-%y.csv -d 'last month')
echo "COPY (SELECT created_at, score FROM surveys WHERE created_at > now() - interval '1' month) TO STDOUT WITH CSV DELIMITER ',';" | psql -o $filename customersatisfactionapp_development
mailx -a $filename -s "Reporte mensual satisfacción de usuarios" "some@mail.com" < reports/mail_cont.txt

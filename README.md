# README

Este proyecto es una página web para captar la satisfacción de usuario, dichos datos son enviados por correo electronico una vez al mes como un archivo `csv`.

Las dependencias y versiones utilizadas son las siguientes:

 * Ruby 2.6
 
 * Rails 5.2.2
 
 * PostgreSQL 11.2
 
 * Bundler 1.17.2
 
 * mailx 12.5
 
Para hacer correr la applicación:

```bash
  $ bundle install
  $ sudo -u postgres createuser $(whoami)
  $ rake db:create
  $ bin/rails db:migrate RAILS_ENV=development
  $ bin/rails server
```

Además se debe configurar el mail desde donde se enviarán los correos.
Se utiliza Gmail para pasar los filtros de SPAM, la cuenta debe ser configurada para aceptar apps menos seguras: https://myaccount.google.com/lesssecureapps

La cuenta debe ser configurada en `~/.mailrc` de la siguiente forma:

```
account gmail {
    set smtp-use-starttls
    set smtp-auth=login
    set smtp=smtp://smtp.gmail.com:587
    set from="<your mail>(<your name>)"
    set smtp-auth-user=<your mail>
    set smtp-auth-password=<your pass>
    set ssl-verify=ignore
    set nss-config-dir=PATH/TO/certs
}
```

Si existen problemas con el certificado una posible solución es la siguiente:
```
  # From https://serverfault.com/questions/498588/smtp-gmail-com-from-bash-gives-error-in-certificate-peers-certificate-issuer
  $ mkdir certs
  $ certutil -N -d certs
  $ sudo yum install wget
  $ wget https://www.geotrust.com/resources/root_certificates/certificates/GeoTrust_Global_CA.cer
  $ mv GeoTrust_Global_CA.cer certs/
  $ echo -n | openssl s_client -connect smtp.gmail.com:465 -CAfile certs/GeoTrust_Global_CA.cer | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > GMAILCERT
  $ certutil -A -n "Google Internet Authority" -t "C,," -d certs -i GMAILCERT
  $ certutil -L -d certs
```

El correo de recepción puede ser editado en `create-and-send-report.sh` cambiando la variable de entorno `$address`.

Los correos son enviados por medio de la ejecución del script antes mencionado en un cron job.
Ejecutar `crontab -e` y editar el archivo para agregar:

```
  0 0 1 * * /path/to/customersatisfactionapp/create-and-send-report.sh
```

De esta manera el primer día de cada mes se enviará un reporte con las puntuaciones del mes anterior. 

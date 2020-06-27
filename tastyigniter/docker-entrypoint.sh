#!/bin/sh
set -e
echo "this worked" > /var/www/html/bars.txt
curl -o /var/www/html/tastyigniter.zip -fSL "https://codeload.github.com/tastyigniter/setup/zip/master"
unzip /var/www/html/tastyigniter.zip -d /var/www/html
chown -R www-data:www-data /var/www/html/
mv -v /var/www/html/setup-master/* /var/www/html/
echo 'echo "* * * * * php artisan schedule:run >> /dev/null 2>&1"' > /etc/cron.d/artisan
rm /var/www/html/tastyigniter.zip
exec "$@"

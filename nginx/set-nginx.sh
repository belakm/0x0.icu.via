# certbot
certbot certonly --nginx -d 0x0.icu -d www.0x0.icu -m admin@0x0.icu

# cron to refresh certbot
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(3600)' && certbot renew -q" | tee -a /etc/crontab > /dev/null

# copy our configs
mkdir /etc/nginx/conf.d/services/
cp -a /usr/local/bin/nginx/services/* /etc/nginx/conf.d/services/
cp /usr/local/bin/nginx/nginx.conf /etc/nginx/conf.d/

# remove default config
rm /etc/nginx/conf.d/default.conf

echo ""
echo "Please restart nginx or this container."
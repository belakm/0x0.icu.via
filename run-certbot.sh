nginx -g "daemon off;"

# add certbot
apk add certbot certbot-proxy

# set up cert
sudo certbot certonly --nginx 0x0.icu -d 0x0.icu,www.0x0.icu

# set up cron
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

# restart nginx
sudo systemctl restart nginx
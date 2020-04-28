# 0x0.icu.via

Load balancer for 0x0.icu stack

# Usage

## Run certbot
certbot certonly --nginx -d 0x0.icu -m admin@0x0.icu

## Set up cron
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null
# 0x0.icu.via

Reverse proxy for 0x0.icu stack using nginx.

## Usage

### 1. Deploy via Docker

### 2. Set nginx configurations and get a letsencrypt cert for https

Run ´/usr/local/bin/nginx/set-nginx.sh´ to run a script that will 

1. acquire a letsencrypt certificate
2. copy over nginx configurations in /nginx folder

### 3. Restart nginx or container

for new nginx configuration to take effect.
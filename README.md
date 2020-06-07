# 0x0.icu.via

Reverse proxy setup.

## Environment

RancherOS
  |
  -- dockerized nginx on a network
  -- certbot (and autorenewal)
  .
  .
  .
  -- your other services on a network

## Usage

### 1. Switch to alpine console

```shell
sudo ros console switch alpine
```

### 2. Install git and certbot

```shell
$ sudo apk add git certbot
```

### 3. Clone 0x0.icu.via to `~`, copy pre-certbot config and create paths

```shell
git clone https://github.com/belakm/0x0.icu.via.git
$ sudo cp -r ~/0x0.icu.via/pre-certbot/. /var/nginx/conf
$ sudo mkdir /var/nginx
$ sudo mkdir /var/nginx/conf
$ sudo mkdir /var/nginx/html
```

### 4. Create `nginx-net` docker network and run nginx

```shell
$ docker network create nginx-net
$ docker run -d \
  --name nginx \
  --restart unless-stopped \
  --network=nginx-net \
  -p 80:80 \
  -p 443:443 \
  -v /var/nginx/conf:/etc/nginx/conf.d:ro \
  -v /var/nginx/html:/usr/share/nginx/html \
  -v /etc/letsencrypt:/etc/letsencrypt:ro \
  nginx
```

### 5. Run certbot

```shell
$ sudo certbot certonly \
  --webroot \
  -w /var/nginx/html \
  -d example.org
```

### 6. Certs are now available so set a cronjob for auto-renewal

```shell
$ echo '0 0,12 * * * certbot renew --post-hook "nginx -s reload"' > /etc/crontabs/root
```

### 7. prepare your routes in `~/0x0.icu.via/post-certbot/`

**Containers that run on the same docker network (`nginx-net`) are now reachable in nginx config via:**

```nginx
upstream {
  server name_of_your_container;
}
```

### 8. remove old config, copy new config and restart nginx

```shell
$ sudo rm -rf /var/nginx/conf/*
$ sudo cp -r ~/0x0.icu.via/post-certbot/. /var/nginx/conf
$ docker container restart nginx
```

# set the base image
# n/b: for production, node is only used for building 
# the static Html and javascript files
# as react creates static html and js files after build
# these are what will be served by nginx
# use alias build to be easier to refer this container elsewhere
# e.g inside nginx container
FROM nginx:alpine

# add certbot and grep
RUN apk add certbot certbot-nginx grep

# remove default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

RUN mkdir -p /etc/letsencrypt/live/0x0.icu/

COPY fake-cert/cert.pem /etc/letsencrypt/live/0x0.icu/fullchain.pem
COPY fake-cert/key.pem /etc/letsencrypt/live/0x0.icu/privkey.pem

# replace with custom one
ADD nginx /etc/nginx/conf.d

# --------- /only for those using react router ----------
# expose port 80 to the outer world
EXPOSE 80 443

CMD nginx -g "daemon off;"
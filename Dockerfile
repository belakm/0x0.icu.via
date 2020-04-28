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

# replace with custom one
ADD nginx /usr/nginx-confs

COPY run-certbot.sh /usr/bin

# --------- /only for those using react router ----------
# expose port 80 to the outer world
EXPOSE 80 443

CMD ./usr/bin/run-certbot.sh
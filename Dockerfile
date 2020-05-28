# set the base image
# n/b: for production, node is only used for building 
# the static Html and javascript files
# as react creates static html and js files after build
# these are what will be served by nginx
# use alias build to be easier to refer this container elsewhere
# e.g inside nginx container
FROM nginx:alpine

# add certbot
RUN apt-get update && apt-get install -y certbot python-certbot-nginx

# copy script to usr local bin
WORKDIR /usr/local/bin/
COPY nginx nginx/

# give run permission to the users
RUN chmod -R 755 /usr/local/bin/nginx

# expose port 80 to the outer world
EXPOSE 80 443

# start nginx
CMD nginx -g "daemon off;"
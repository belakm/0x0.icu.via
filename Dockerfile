# set the base image
# n/b: for production, node is only used for building 
# the static Html and javascript files
# as react creates static html and js files after build
# these are what will be served by nginx
# use alias build to be easier to refer this container elsewhere
# e.g inside nginx container
FROM nginx:alpine

# remove default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# replace with custom one
ADD nginx /etc/nginx/conf.d

WORKDIR /usr/local/bin

COPY run-cerbot.sh .

# --------- /only for those using react router ----------
# expose port 80 to the outer world
EXPOSE 80 443

# start nginx 
CMD ./run-cerbot.sh
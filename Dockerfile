FROM nginx:latest


LABEL maintainer="Ing. Dominic Annang Maintainers <dominic.annang@ngmail.com>"


#Copy the custom HTML file that displays the message
COPY index.html /usr/share/nginx/html/


# Expose port 80 and 443
EXPOSE 80 443 


# Start NGINX when the container launches
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]


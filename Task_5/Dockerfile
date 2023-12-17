FROM alpine:latest
RUN apk --no-cache add apache2
WORKDIR /var/www/localhost/htdocs
RUN echo "<h1>Hello Word!</h1>" > index.html
EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]

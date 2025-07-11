FROM alpine:latest

RUN rm -rf /usr/share/nginx/html/*

COPY . /usr/share/nginx/html

RUN apk update && apk add --no-cache libxml2 && mkdir -p /run/nginx

RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

EXPOSE 80

USER nginx

CMD ["nginx", "-g", "daemon off;"]


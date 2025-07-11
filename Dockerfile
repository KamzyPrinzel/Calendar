FROM alpine:latest

RUN apk update && \
    apk add --no-cache nginx libxml2 && \
    mkdir -p /run/nginx && \
    rm -rf /var/cache/apk/*

COPY . /usr/share/nginx/html

RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chmod -R 755 /usr/share/nginx/html

EXPOSE 80


USER nginx

CMD ["nginx", "-g", "daemon off;"]
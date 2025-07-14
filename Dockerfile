FROM alpine:3.18  


RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
    nginx=1.24.0-r14 \
    libxml2=2.11.0-r0 \
    && mkdir -p /run/nginx \
    && rm -rf /var/cache/apk/* \
    && rm -rf /etc/nginx/conf.d/default.conf  


COPY nginx.conf /etc/nginx/nginx.conf


COPY . /usr/share/nginx/html


RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod -R 750 /usr/share/nginx/html \
    && chown -R nginx:nginx /var/log/nginx \
    && chown -R nginx:nginx /var/lib/nginx \
    && find /usr/share/nginx/html -type d -exec chmod 755 {} \;

EXPOSE 80

USER nginx:nginx

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]

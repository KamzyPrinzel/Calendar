FROM alpine:3.18

# Install Nginx with compatible versions
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache \
    nginx \
    libxml2 \
    && mkdir -p /run/nginx \
    && rm -rf /var/cache/apk/* \
    && rm -rf /etc/nginx/conf.d/default.conf

# Verify installed versions
RUN nginx -v && \
    apk info libxml2 | head -1

COPY nginx.conf /etc/nginx/nginx.conf
COPY . /usr/share/nginx/html

# Security hardening
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && chmod -R 750 /usr/share/nginx/html \
    && chown -R nginx:nginx /var/log/nginx \
    && chown -R nginx:nginx /var/lib/nginx

EXPOSE 80
USER nginx
CMD ["nginx", "-g", "daemon off;"]

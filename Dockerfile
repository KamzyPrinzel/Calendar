FROM nginx:1.25-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY . /usr/share/nginx/html

RUN apk update && apk add --no-cache libxml2

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


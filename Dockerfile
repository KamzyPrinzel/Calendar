FROM nginx:1.25-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY . /usr/share/nginx/html

RUN apt-get update && apt-get upgrade -y libxml2 && apt-get clean && rm -rf /var/lib/apt/list/*

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

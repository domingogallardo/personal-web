FROM alpine:3.20

RUN apk add --no-cache nginx tzdata \
    && mkdir -p /run/nginx

ENV TZ=Europe/Madrid

COPY public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

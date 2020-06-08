# What is RainLoop?

Rainloop is a simple, modern & fast web-based email client.

http://www.rainloop.net/

# How to use this image

```console
$ docker run -p 80:80 -d nicokaiser/rainloop
```

## ... via [`docker-compose`](https://github.com/docker/compose)

Example `docker-compose.yml`:

```yaml
version: '2'
services:
  rainloop:
    image: 'nicokaiser/rainloop'
    ports:
      - 80:80
    volumes:
      - rainloop_data:/var/www/html/data
volumes:
  rainloop_data:
    driver: local
```

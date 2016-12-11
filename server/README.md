# NewsTrust


------

* [What](#what)
* [Server](#server)
* [Testing](#testing)
  - [Creating Page views](#create-pageview)
  - [Creating Page flags](#create-flag)
* [Architecture](#architecture)

-----

## What

NewsTrust is an app and chrome extension for tracking confidence in news articles.

## Server

```bash
# build case container
docker build -t newstrust-base ops/newstrust-base/.

docker-compose up
```

## Testing

```
docker-compose -f docker-compose.test.yml up
```

### Create pageview

```bash
curl "http://$(docker-machine ip):9292/page_views" -H 'Content-Type: application/json' --data '{"url":"https://news.ycombinator.com/","uuid":"cb75ee7e83ab808084e244ae23175f625291a9df63ad0754957754b5fd9479"}'
{"rating":"A","view_count":1,"flag_count":0}
```

### Create flag

```bash
curl "http://$(docker-machine ip):9292/flags" -H 'Content-Type: application/json' --data '{"url":"https://news.ycombinator.com/","uuid":"cb75ee7e83ab808084e244ae23175f625291a9df63ad0754957754b5fd9479"}'
{"rating":"A","view_count":1,"flag_count":1}
```

## Architecture

Chrome extension that records page views for per visit and flags when user reports a given page. The ratio of page views to flags determines the confidence rating for an individual page and displays the given rating (A through F).

     +---------+                                 +---------------+
     |         |--(A)- POST /page_view --------->|               |
     |         |                                 |               |
     |         |<-(B)- Reply with views & flags -|               |
     |         |          [Rating A]             |               |
     | Browser |                                 |   NewsTrust   |
     | Client  |                                 |     Server    |
     |         |--(C)---- POST /flag    -------->|               |
     |         |                                 |               |
     |         |<-(D)- Reply with views & flags -|               |
     |         |          [Rating B]             |               |
     +---------+                                 +---------------+

# NewsTrust


------

* [What](#what)
* [Server](#server)
* [Testing](#testing)
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

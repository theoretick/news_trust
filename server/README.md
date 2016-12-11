# NewsTrust


------

* [What](#what)
* [Architecture](#architecture)

-----

## What

NewsTrust is an app and chrome extension for tracking confidence in news articles.

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

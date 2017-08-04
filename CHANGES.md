## In the next release

## 0.1.5 2017-08-04

* Add linkerd-health dashboard

## 0.1.4 2017-07-27

* Make Consul hostname configurable via `CONSUL_HOST` environment variable
* Make Marathon hostname configurable via `MARATHON_HOST` environment variable
* Deprecate `mesos-marathon` config in favor of setting `MARATHON_HOST`

## 0.1.3 2017-07-24

* Updated Consul config for simplified linkerd metric names

## 0.1.2 2017-07-19

* Set default Prometheus `scrape_interval` and `evaluation_interval` to `30s`,
  to ensure Grafana `irate` graphs render properly.
* Fixed `scrape_interval` configuration not being honored.

## 0.1.1 2017-07-12

* Set default Prometheus `scrape_interval` and `evaluation_interval` to `1m`, make configurable.

## 0.1.0 2017-04-25

* Updated for linkerd 1.0 metrics. This is a breaking change. This version of
  linkerd-viz will only work with linkerd 1.0+. Previous versions of
  linkerd-viz will only with linkerd prior to 1.0.
* Moved to linkerd Github org

## 0.0.10 2017-04-01

* Updated latency y-axis to be in ms
* Updated docker image to be slimmer

## 0.0.9 2017-03-08

* Add router drop-down selector and template variable
* Add mesos-marathon local config
* Update metrics labels for linkerd 0.9.0

## 0.0.7 2017-01-19

* Updated default Prometheus port from 9090 to 9191
* Updated Prometheus relabel configs for linkerd 0.8.6
* Updated startup script to run Prometheus as pid 1 #8
* Fixed automated build #1

## 0.0.5 2016-10-05

* Initial release

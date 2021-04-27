[![Docker Pulls](https://img.shields.io/docker/pulls/buoyantio/linkerd-viz.svg)](https://hub.docker.com/r/buoyantio/linkerd-viz/)

# Upgrade Notice

This repo is for Linkerd 1. For instructions on setting up the Linkerd 2 viz
extension, see the [Linkerd 2 documentation](https://linkerd.io/2/tasks/extensions/).

# linkerd-viz

Dead simple monitoring for [linkerd](https://linkerd.io).

![linkerd-viz screenshot](https://linkerd.io/images/linkerd-viz.png "linkerd-viz screenshot")

linkerd-viz is a monitoring application based on
[Prometheus](https://prometheus.io/) and [Grafana](http://grafana.org/),
autoconfigured to collect metrics from [linkerd](https://linkerd.io).
linkerd-viz currently supports [DC/OS](https://dcos.io/) and
[Kubernetes](http://kubernetes.io/).

linkerd-viz assumes linkerd has already been deployed onto your cluster, and
your applications have been configured to route via linkerd. You'll also need
to configure linkerd with the `io.l5d.prometheus` telemeter, to expose the stats
that are displayed by linkerd-viz. You should add this block to your linkerd
configuration file:

```yaml
telemetry:
- kind: io.l5d.prometheus
```

For more information on getting started with linkerd have a look at our [Getting
Started guides](https://linkerd.io/getting-started/).

## Build Docker image

```bash
docker build -t buoyantio/linkerd-viz .
```

## Local boot

```bash
docker run -p 3000:3000 -p 9191:9191 buoyantio/linkerd-viz
```

## DC/OS Deploy

Install the official linkerd-viz DC/OS Universe package

```bash
dcos package install linkerd-viz
```

Custom installation

```bash
dcos marathon app add dcos/linkerd-viz.json
```

View dashboard

```bash
open $PUBLIC_NODE:3000
```

## Kubernetes Deploy

```bash
kubectl apply -f k8s/linkerd-viz.yml
```

View dashboard

```bash
kubectl port-forward $(kubectl get po --selector=name=linkerd-viz -o jsonpath='{.items[*].metadata.name}') 3000:3000
open http://localhost:3000
```

## Consul Deploy

First, examine and edit `consul/prometheus-consul.yml` to fit your ecosystem.

Run the Consul agent locally:

```bash
docker run -d --net=host consul:0.9.0 agent -bind=<external ip> -retry-join=<root agent ip>
```
for more information see [Running Consul Agent in Client Mode](https://hub.docker.com/_/consul/).

Boot `linkerd-viz` locally:

```bash
docker run -d --net=host -p 3000:3000 -p 9191:9191 buoyantio/linkerd-viz:0.2.0 consul
```

View dashboard

```bash
open localhost:3000
```

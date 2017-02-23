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
docker build -t buoyantio/linkerd-viz:latest .
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
open http://$(kubectl get svc linkerd-viz -o jsonpath="{.status.loadBalancer.ingress[0].*}")
```

## Consul Deploy

First, examine and edit `consul/prometheus-consul.yml` to fit your ecosystem.

Run the Consul agent locally:
```bash
docker run -d --net=host -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' consul agent -bind=<external ip> -retry-join=<root agent ip>
```
for more information see [Running Consul Agent in Client Mode](https://hub.docker.com/_/consul/).

Boot `linkerd-viz` locally:
```bash
docker run -p 3000:3000 -p 9191:9191 buoyantio/linkerd-viz consul
```

View dashboard

```bash
open localhost:3000
```

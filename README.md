# linkerd-viz

Dead simple monitoring for [linkerd](https://linkerd.io).

![linkerd-viz screenshot](https://linkerd.io/images/linkerd-viz.png "linkerd-viz screenshot")

linkerd-viz is a monitoring application based on
[Prometheus](https://prometheus.io/) and [Grafana](http://grafana.org/),
autoconfigured to collect metrics from [linkerd](https://linkerd.io).
linkerd-viz currently supports [DC/OS](https://dcos.io/) and
[Kubernetes](http://kubernetes.io/).

linkerd-viz assumes linkerd has already been deployed onto your cluster, and
your applications have been configured to route via linkerd. For more
information on getting started with linkerd have a look at our [Getting Started
guides](https://linkerd.io/getting-started/).

## Build and push Docker image

```bash
./dockerize [docker-tag]
```

Default `docker-tag` is `buoyantio/linkerd-viz:latest`

## Local boot

```bash
docker run -p 3000:3000 -p 9090:9090 buoyantio/linkerd-viz
```

## DC/OS Deploy

Install the official linkerd-viz DC/OS Universe package

```bash
dcos package install linkerd-viz
```

Custom installation

```bash
dcos marathon app add dcos/linkerd-viz-prometheus.json
dcos marathon app add dcos/linkerd-viz-grafana.json
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
open http://$(kubectl get svc linkerd-viz -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
```

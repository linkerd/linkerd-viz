# linkerd-viz

Dead simple monitoring for [linkerd](https://linkerd.io).

![linkerd-viz screenshot](https://linkerd.io/images/dcos/linkerd-viz-screenshot.png "linkerd-viz screenshot")

linkerd-viz is a monitoring application based on
[Prometheus](https://prometheus.io/) and [Grafana](http://grafana.org/),
autoconfigured to collect metrics from [linkerd](https://linkerd.io).
linkerd-viz currently supports [Kubernetes](http://kubernetes.io/) and
[DC/OS](https://dcos.io/).

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

## Kubernetes Deploy

```bash
kubectl apply -f linkerd-viz-k8s.yml
```

View dashboard

```bash
open http://$(kubectl get svc linkerd-viz -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
```

## DC/OS Deploy

```bash
dcos marathon app add linkerd-viz-dcos.json
```

View dashboard

```bash
open $PUBLIC_NODE:3000
```

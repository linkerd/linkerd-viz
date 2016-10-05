FROM grafana/grafana:3.1.1
MAINTAINER  Buoyant, Inc. <hello@buoyant.io>

RUN apt-get update && \
    apt-get -y --no-install-recommends install curl

COPY . /
COPY etc/grafana/dashboards/linkerd-viz-dashboard.json /usr/share/grafana/public/dashboards/home.json

EXPOSE 3000 9090

ENTRYPOINT [ "/linkerd-viz" ]

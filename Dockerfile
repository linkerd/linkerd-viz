FROM grafana/grafana:3.1.1
MAINTAINER  Buoyant, Inc. <hello@buoyant.io>

EXPOSE 3000 9191

RUN apt-get update                                       && \
    apt-get -y --no-install-recommends install curl wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/grafana/dashboards
RUN mkdir -p /etc/prometheus

# prometheus setup

RUN wget https://github.com/prometheus/prometheus/releases/download/v1.4.1/prometheus-1.4.1.linux-amd64.tar.gz && \
    tar -xf /prometheus-1.4.1.linux-amd64.tar.gz                                                               && \
    cp      /prometheus-1.4.1.linux-amd64/prometheus        /bin/                                              && \
    cp      /prometheus-1.4.1.linux-amd64/promtool          /bin/                                              && \
    cp -a   /prometheus-1.4.1.linux-amd64/console_libraries /etc/prometheus/                                   && \
    cp -a   /prometheus-1.4.1.linux-amd64/consoles          /etc/prometheus/                                   && \
    rm -rf  /prometheus-1.4.1.linux-amd64*

# linkerd-viz setup

COPY linkerd-viz                /linkerd-viz
COPY */prometheus-*.yml         /etc/prometheus/
COPY linkerd-viz-dashboard.json /etc/grafana/dashboards/linkerd-viz-dashboard.json
COPY linkerd-viz-dashboard.json /usr/share/grafana/public/dashboards/home.json

ENTRYPOINT [ "/linkerd-viz" ]

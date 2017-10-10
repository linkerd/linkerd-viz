FROM prom/prometheus:v1.7.1 as prometheus

FROM grafana/grafana:4.5.1
MAINTAINER  Buoyant, Inc. <hello@buoyant.io>

EXPOSE 3000 9191

RUN apt-get update                                  && \
    apt-get -y --no-install-recommends install curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN sqlite3 /var/lib/grafana/grafana.db
# UPDATE user SET help_flags1=0 WHERE login='admin';
# INSERT INTO "data_source" VALUES(1,1,0,'prometheus','prometheus','proxy','http://localhost:9191','','','',0,'','',1,'{}','2017-09-15 23:33:18','2017-09-15 23:33:18',0,'{}');

RUN mkdir -p /var/lib/grafana/dashboards
RUN mkdir -p /etc/prometheus

# prometheus setup

# RUN wget https://github.com/prometheus/prometheus/releases/download/v1.4.1/prometheus-1.4.1.linux-amd64.tar.gz && \
#     tar -xf /prometheus-1.4.1.linux-amd64.tar.gz                                                               && \
#     cp      /prometheus-1.4.1.linux-amd64/prometheus        /bin/                                              && \
#     cp      /prometheus-1.4.1.linux-amd64/promtool          /bin/                                              && \
#     cp -a   /prometheus-1.4.1.linux-amd64/console_libraries /etc/prometheus/                                   && \
#     cp -a   /prometheus-1.4.1.linux-amd64/consoles          /etc/prometheus/                                   && \
#     rm -rf  /prometheus-1.4.1.linux-amd64*

COPY --from=prometheus /bin/prometheus                     /bin/
COPY --from=prometheus /bin/promtool                       /bin/
COPY --from=prometheus /etc/prometheus/console_libraries   /etc/prometheus/
COPY --from=prometheus /etc/prometheus/consoles            /etc/prometheus/

# linkerd-viz setup

COPY linkerd-viz                   /linkerd-viz
COPY */prometheus-*.yml            /etc/prometheus/
COPY linkerd-health-dashboard.json /var/lib/grafana/dashboards/linkerd-health-dashboard.json
COPY linkerd-viz-dashboard.json    /var/lib/grafana/dashboards/linkerd-viz-dashboard.json
COPY linkerd-viz-dashboard.json    /usr/share/grafana/public/dashboards/home.json

ENTRYPOINT [ "/linkerd-viz" ]

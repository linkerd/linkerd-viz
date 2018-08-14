FROM grafana/grafana:5.2.2
LABEL maintainer="linkerd-users@googlegroups.com"

# mimic behavior from grafana/grafana:4.6.2, to allow for copying files onto this image's local filesystem
USER root

EXPOSE 3000 9191

ARG prometheus_version=2.3.2
ARG prometheus_archive_name=prometheus-$prometheus_version.linux-amd64

RUN mkdir -p /etc/prometheus

# prometheus setup
RUN curl -L -o $prometheus_archive_name.tar.gz https://github.com/prometheus/prometheus/releases/download/v$prometheus_version/$prometheus_archive_name.tar.gz && \
    tar -xf /$prometheus_archive_name.tar.gz                                                               && \
    cp      /$prometheus_archive_name/prometheus        /bin/                                              && \
    cp      /$prometheus_archive_name/promtool          /bin/                                              && \
    cp -a   /$prometheus_archive_name/console_libraries /etc/prometheus/                                   && \
    cp -a   /$prometheus_archive_name/consoles          /etc/prometheus/                                   && \
    rm -rf  /$prometheus_archive_name*

# linkerd-viz setup
COPY linkerd-viz                                   /linkerd-viz
COPY */prometheus-*.yml                            /etc/prometheus/
COPY grafana/dashboards.yaml                       $GF_PATHS_PROVISIONING/dashboards/
COPY grafana/dashboards/*                          $GF_PATHS_PROVISIONING/dashboards/
COPY grafana/dashboards/linkerd-viz-dashboard.json $GF_PATHS_HOME/public/dashboards/home.json

ENTRYPOINT [ "/linkerd-viz" ]

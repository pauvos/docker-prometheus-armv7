FROM resin/rpi-raspbian:jessie

ENV PROM_VERSION=1.5.2

RUN apt-get update \
	&& apt-get install -qy curl \
	&& curl -sLO https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-armv7.tar.gz \
	&& mkdir /opt/prometheus \
	&& tar xzf prometheus-$PROM_VERSION.linux-armv7.tar.gz -C /opt/prometheus/ --strip-components=1 \
 	&& rm prometheus-$PROM_VERSION.linux-armv7.tar.gz

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/opt/prometheus/prometheus" ]

CMD        [ "-config.file=/opt/prometheus/prometheus.yml", \
						"-storage.local.path=/prometheus", \
						"-web.console.libraries=/opt/prometheus/console_libraries", \
						"-web.console.templates=/opt/prometheus/consoles" ]

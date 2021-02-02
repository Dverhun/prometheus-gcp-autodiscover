FROM prom/prometheus
ADD prometheus.yml /etc/prometheus/


RUN mkdir -p ${HOME}/.config/gcloud/ && \
    mkdir  /prometheus/tgroups


COPY ./gcp_service_account_sample_1234567.json /home/.config/gcloud/
COPY sbx_targets.yml /prometheus/tgroups/sbx_targets.yml


ENV GOOGLE_APPLICATION_CREDENTIALS=/home/.config/gcloud/gcp_service_account_sample_1234567.json

WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" , \
             "--log.level=debug" ]

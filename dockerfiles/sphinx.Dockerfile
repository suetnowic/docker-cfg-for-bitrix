FROM ubuntu:16.04

ARG APP_ENV=dev

RUN apt-get update \
    && apt-get -y install \
        software-properties-common

RUN add-apt-repository ppa:builds/sphinxsearch-rel22 \
    && apt-get update \
    && apt-get -y install \
        mysql-client \
        unixodbc \
        libpq5 \
        sphinxsearch \
    && apt-get remove -y software-properties-common \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && rm -r /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/sphinxsearch/searchd.log \
    && ln -sf /dev/stderr /var/log/sphinxsearch/query.log

COPY dockerfiles/start.sh /start.sh

RUN chmod +x /start.sh

VOLUME ["/etc/sphinxsearch"]
VOLUME ["/var/lib/sphinxsearch/data"]

EXPOSE 9312 9306

CMD ["/start.sh"]

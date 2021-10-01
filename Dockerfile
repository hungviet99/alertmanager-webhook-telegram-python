FROM alpine:3.7

LABEL maintainer "Carlos Augusto Malucelli <malucellicarlos@gmail.com>"

RUN apk update \
                && apk add py3-pip bash gcc python3-dev musl-dev libffi-dev openssl-dev \
                && rm -rf /var/cache/apk/* \
                && wget https://github.com/nopp/alertmanager-webhook-telegram/archive/master.zip \
                && unzip master.zip \
                && pip3 install -r alertmanager-webhook-telegram-python-master/requirements.txt

WORKDIR /alertmanager-webhook-telegram-python

COPY run.sh /alertmanager-webhook-telegram-python

COPY flaskAlert.py /alertmanager-webhook-telegram-python

RUN chmod +x /alertmanager-webhook-telegram-python/run.sh

RUN chmod +x /alertmanager-webhook-telegram-python/flaskAlert.py

EXPOSE 9119

ENTRYPOINT ["./run.sh"]
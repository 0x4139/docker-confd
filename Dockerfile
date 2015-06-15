FROM debian:latest
MAINTAINER Vali Malinoiu
WORKDIR /usr/local/bin/
RUN apt-get update -y
RUN apt-get install curl -y
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64 -o confd
RUN chmod +x confd
RUN ls
RUN mkdir -p /etc/confd/{conf.d,templates}
ADD hosts.toml /etc/confd/conf.d/
ADD hosts.tmpl /etc/confd/templates/
ADD run.sh /usr/local/bin/
RUN chmod +x run.sh
CMD run.sh

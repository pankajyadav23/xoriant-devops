#!/bin/bash
# Author : Pankaj Yadav
# What does the script do:
#       1. Add users prometheus and node_exporter
#       2. Download prometheus-1.8 and intall it on local system
#       3. Dowmload node_exporter-0.15.0 and install it.
#       4. start node exporter as service
#       5. Start prometheus-1.8
#       6. Perform a "./Prometheus-1.8.sh" ->> This should succeed

sudo useradd  prometheus
sudo useradd --no-create-home --shell /bin/false node_exporter
sudo groupadd prometheus
sudo mkdir /home/prometheus/
sudo chown prometheus:prometheus /home/prometheus/
cd /home/prometheus/
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
curl -LO https://github.com/prometheus/prometheus/releases/download/v1.8.0/prometheus-1.8.0.linux-amd64.tar.gz 
tar xvf prometheus-1.8.0.linux-amd64.tar.gz
sudo cp /home/prometheus/prometheus-1.8.0.linux-amd64/prometheus /usr/local/bin/
sudo cp /home/prometheus/prometheus-1.8.0.linux-amd64/promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp /tmp/prometheus-1.8.yml  /etc/prometheus/
sudo cp /tmp/prometheus.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
#sudo systemctl status prometheus
#sleep 10 
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.15.0/node_exporter-0.15.0.linux-amd64.tar.gz
tar xvf node_exporter-0.15.0.linux-amd64.tar.gz
sudo cp /home/prometheus/node_exporter-0.15.0.linux-amd64/node_exporter /usr/local/bin
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
sudo cp /tmp/node_exporter.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start node_exporter
#sudo systemctl status node_exporter
#exit

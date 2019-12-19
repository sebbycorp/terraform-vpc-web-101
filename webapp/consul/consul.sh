#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"


#Utils
sudo apt-get update
sudo apt-get install awscli
sudo apt-get install unzip

#Download Consul
CONSUL_VERSION="1.6.2"
curl --silent --remote-name https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
curl --silent --remote-name https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS
curl --silent --remote-name https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig

#Install Consul
unzip consul_${CONSUL_VERSION}_linux_amd64.zip
sudo chown root:root consul
sudo mv consul /usr/local/bin/
consul --version

consul -autocomplete-install
complete -C /usr/local/bin/consul consul

#Create Consul User
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir --parents /opt/consul
sudo chown --recursive consul:consul /opt/consul

#Create Systemd Config
sudo cat << EOF > /etc/systemd/system/consul.service
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=notify
User=consul
Group=consul
ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/usr/local/bin/consul reload
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

#Create config dir
sudo mkdir --parents /etc/consul.d
sudo touch /etc/consul.d/consul.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul.hcl

cat << EOF > /etc/consul.d/consul.hcl
datacenter = "us-east-1-dc1"
data_dir = "/opt/consul"

ui = true

performance {
  raft_multiplier = 1
}
EOF

#Server build
sudo mkdir --parents /etc/consul.d
sudo touch /etc/consul.d/server.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/server.hcl


cat << EOF > /etc/consul.d/server.hcl
server = true
bootstrap_expect = 3

ui = true
client_addr = "0.0.0.0"
EOF

#Enable the service
sudo systemctl enable consul
sudo service consul start
sudo service consul status


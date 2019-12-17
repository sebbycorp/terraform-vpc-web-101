#!/bin/bash

#Get IP
local_ipv4="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"


#Utils
sudo apt-get install unzip

#Download Consul
VAULT_VERSION="1.3.0"
curl --silent --remote-name https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
curl --silent --remote-name https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS
curl --silent --remote-name https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS.sig

#Install Consul
unzip vault_${VAULT_VERSION}_linux_amd64.zip
sudo chown root:root vault
sudo mv vault /usr/local/bin/
vault --version

#install
vault -autocomplete-install
complete -C /usr/local/bin/vault vault

#Give Vault the ability to use the mlock syscall without running the process as root. The mlock syscall prevents memory from being swapped to disk.
sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault

#Create a unique, non-privileged system user to run Vault.
sudo useradd --system --home /etc/vault.d --shell /bin/false vault

#Create Systemd Config


sudo cat << EOF > /etc/systemd/system/vault.service
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitInterval=60
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
EOF




#Create config dir
sudo mkdir --parents /etc/vault.d
sudo touch /etc/vault.d/vault.hcl
sudo chown --recursive vault:vault /etc/vault.d
sudo chmod 640 /etc/vault.d/vault.hcl

#Enable the service
sudo systemctl enable vault
sudo systemctl start vault
sudo systemctl status vault
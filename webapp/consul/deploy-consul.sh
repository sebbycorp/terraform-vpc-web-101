
cat << EOF > /etc/consul.d/consul.hcl
datacenter = "us-east-1-dc1"
data_dir = "/opt/consul"

ui = true
EOF

cat << EOF > /etc/consul.d/server.hcl
server = true
bootstrap_expect = 1

client_addr = "0.0.0.0"
retry_join = ["provider=aws tag_key=Env tag_value=consul"]
EOF

#Enable the service
sudo systemctl enable consul
sudo service consul start
sudo service consul status
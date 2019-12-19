#Deploying consul

log into the consul servers and get consul key gen

input the keygen into sudo vi /etc/consul.d/server.hcl 
encyrpt = "asdfasdf"

consul join 10.0.2.102 10.0.1.202 10.0.5.196

retry_join = ["provider=aws tag_key=Env tag_value=consul"]

consul agent -retry-join "provider=aws tag_key=Env tag_value=consul"

consul join "provider=aws tag_key=infra-consul2 tag_value=infra-consul1 tag_value=infra-consul3"

consul agent \
 -retry-join "provider=aws tag_key=Env tag_value=consul"

{
 "service": {
 "name": "my-service",
 "tags": ["tag-1", "tag-2"],
 "port": 1234
 }
}
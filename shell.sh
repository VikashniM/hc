#!/bin/sh

# microsoft package
sudo wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

#moby engine
sudo apt-get update
sudo apt-get install -y moby-engine

#iot defender
sudo apt-get update
sudo apt-get install -y aziot-edge defender-iot-micro-agent-edge

#pre-req for python script
sudo apt-get update
sudo apt-get install -y python3-pip
pip install azure-keyvault-certificates azure-identity azure-keyvault-secrets

#update config file

sudo sh -c "cat > /etc/aziot/config.toml" << 'EOF' 
auto_reprovisioning_mode="AlwaysOnStartup"
[provisioning]
source = "dps"
global_endpoint = "https://global.azure-devices-provisioning.net"
id_scope = "0ne008356BE"
# Uncomment to send a custom payload during DPS registration
# payload = { uri = "PATH_TO_JSON_FILE" }
[provisioning.attestation]
method = "x509"
#registration_id = "Azure IoT Hub Intermediate Cert Test Only"
registration_id = "device-01"
#identity_cert = "file:///home/adminuser/backup/azure-iot-test-only.intermediate.cert.pem"
#identity_pk = "file:///home/adminuser/backup/azure-iot-test-only.intermediate.key.pem"
identity_cert = "file:///home/adminuser/backup/device-01-IIm-full-chain.cert.pem"
identity_pk = "file:///home/adminuser/backup/device-01.key.pem"
[aziot_keys]
[preloaded_keys]
[cert_issuance]
[preloaded_certs]
[tpm]
[agent]
name = "edgeAgent"
type = "docker"
imagePullPolicy = "on-create"
[agent.config]
image = "mcr.microsoft.com/azureiotedge-agent:1.4"
[agent.config.createOptions]
[agent.env]
[connect]
workload_uri = "unix:///var/run/iotedge/workload.sock"
management_uri = "unix:///var/run/iotedge/mgmt.sock"
[listen]
workload_uri = "fd://aziot-edged.workload.socket"
management_uri = "fd://aziot-edged.mgmt.socket"
min_tls_version = "tls1.0"
[watchdog]
max_retries = "infinite"
[moby_runtime]
uri = "unix:///var/run/docker.sock"
network = "azure-iot-edge"
EOF

#set env variables
#export AZURE_CLIENT_ID="5a50ed53-0a78-4b7b-9b74-c301a663aed6"
#export AZURE_CLIENT_SECRET="mrD8Q~OkYGaKHpLugvoI0hrWuQiEXj8usDsj7atv"
#export AZURE_TENANT_ID="6bc44698-b191-4f2e-97ac-cd7b430088cf"
#export VAULT_URL="https://key-edge-dev-infra-001.vault.azure.net"


#download python script
#FILEPATH=""
#mkdir certificates
#cd certificates
#git clone https://github.com/VikashniM/hc.git
#cd hc
#python3 download.py
#./download.sh

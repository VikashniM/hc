#!/usr/bin/python

from azure.identity import DefaultAzureCredential,EnvironmentCredential
from azure.keyvault.certificates import CertificateClient
from azure.keyvault.secrets import SecretClient
import base64
import os
KVUri=os.environ["VAULT_URL"]
credential =EnvironmentCredential()
client = CertificateClient(vault_url= KVUri,credential= credential,connection_verify=False)
cert_name=input("Enter Certificate Name: ")
cert_pfx=cert_name+".pfx"
print(cert_pfx)
try:
    client_cert = client.get_certificate_version(certificate_name=cert_name, version="x509-cert")
    cert_byte = client_cert.cer
    with open(cert_pfx,'wb') as fopen:
        fopen.write(cert_byte)
except Exception as ex:
    print("no such file in vault")

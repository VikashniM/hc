from azure.identity import DefaultAzureCredential,EnvironmentCredential
from azure.keyvault.certificates import CertificateClient
from azure.keyvault.secrets import SecretClient
import base64
import os

# KVUri = "https://" + "gevault2" + ".vault.azure.net"
KVUri=os.environ["VAULT_URL"]
# credential = DefaultAzureCredential(connection_verify=False, exclude_shared_token_cache_credential=True)
# client = CertificateClient(vault_url= KVUri,credential= credential,connection_verify=False)

credential =EnvironmentCredential()
client = CertificateClient(vault_url= KVUri,credential= credential,connection_verify=False)
# client =SecretClient(vault_url=KVUri, credential=credential)
cert_name=input("Enter Certificate Name: ")

cert_pfx=cert_name+".pfx"
print(cert_pfx)
# cert=client.get_secret(name=cert_name,version="x509-cert")
# cert_byte=base64.decodebytes(cert)
# with open(cert_pfx,'wb') as fopen:
#         fopen.write(cert_byte)
# client_cert = client.get_certificate(cert_name,"x509-cert")
try:
    client_cert = client.get_certificate_version(certificate_name=cert_name, version="x509-cert")
    cert_byte = client_cert.cer
    with open(cert_pfx,'wb') as fopen:
        fopen.write(cert_byte)
except Exception as ex:
    print("no such file in vault")

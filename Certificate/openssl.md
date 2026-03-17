# openssl

## commands
```sh
###########
# Get Version
openssl version

###########
# OpenSSL command below will generate a 2048-bit RSA private key and CSR 
# https://www.ssl.com/how-to/manually-generate-a-certificate-signing-request-csr-using-openssl/

## Create CSR and keypair (need to fill out info.)
openssl req -newkey rsa:2048 -keyout PRIVATEKEY.key -out MYCSR.csr

##############
# generate keypair
openssl genrsa -out keyPair.key 2048

# Export Public Key from keypair
openssl rsa -in keyPair.key -pubout -out public.key

# Create CSR from keypair (need to fill out info. -config pass params )
openssl req -new -key keyPair.key -pubout -out example.csr


# Check CSR
openssl req -text -in example.csr -noout -verify

# self sign cert from keypair
openssl x509 -in example.csr -out example.crt -rep -signkey keyPair.key -days 365

# Get Expire date
openssl x509 -enddate -noout -in file.pem

# Azure Import Cert Logic
cat pkcs12.b64 | base64 -d > pkcs12.bin
openssl pkcs12 -nocerts -passin pass: -in pkcs12.bin -nodes | openssl rsa > priv.pem
openssl pkcs12 -nokeys -clcerts -passin pass: -in pkcs12.bin -nodes | openssl x509 > pub.pem
wget https://certs.godaddy.com/repository/gdig2.crt.pem # Get Intermediate Cert
cat priv.pem pub.pem gdig2.crt.pem > thecert.pem

# split pem
awk 'BEGIN {c=0;} /BEGIN CERTIFICATE/{c++} { print > "cert." c ".pem"}' thecert.pem
```

## Verify Key/CSR
- cmd: 
```sh
## Verify Key
# if password, will prompt
openssl rsa -in private.key -check 
# pass in password
openssl rsa -in private.key -check -passin pass:YourPassword

## Verify a Private Key Matches a Certificate/CSR 
# get md5 of key
openssl rsa -noout -modulus -in private.key | openssl md5
# get md5 of csr
openssl req -noout -modulus -in sslcert.csr | openssl md5
# get md5 of cert
openssl x509 -noout -modulus -in certificate.crt | openssl md5

## Verify a Certificate Chain
openssl verify -CAfile ca_bundle.pem server.crt
```
- if key is encrypted, "-----BEGIN ENCRYPTED PRIVATE KEY-----"
- if key is not encrypted, "-----BEGIN PRIVATE KEY-----"


## commands from Ryan
- if in cmd, replace openssl with `"C:\Program Files\Git\mingw64\bin\openssl.exe"`
- if in powershell, replace openssl with `& 'C:\Program Files\Git\mingw64\bin\openssl.exe'`

```sh
## Create KeyPair and CSR with Password zzzzz
#   -nodes: "no DES" Private Key not encrypted
#   -passout: Set password for Key
# Notes: -nodes & -passout conflict. No password will be set
openssl req -newkey rsa:2048 -nodes -keyout "./private.key" -out "./sslcert.csr" -passout pass:zzzzz -config "./san.cnf.txt"

## Create pk12\pfx Certificate from PEM (provided)
openssl pkcs12 -export -out "./Cert.p12" -in "./star_example_com.pem" -inkey "./private.key" -passin pass:zzzzzz -passout pass:zzzzzz

## Create PEM from pk12 Certificate
openssl pkcs12 -in "./Cert.p12" -out "./newfile.crt.pem" -clcerts -nokeys -passin pass:zzzzzz

## for FTP server ??
# Extract Key from cert (Is it needed? isn't this just the private key)
openssl pkcs12 -in "./Cert.p12" -nocerts -out "./Cert.key" -passin pass:zzzzzz

# Extract Crt from cert (Is it needed? isn't this just the PEM)
openssl pkcs12 -in "./Cert.p12" -clcerts -nokeys -out "./Cert.crt" -passin pass:zzzzzz

```

### san.cnf.txt
```ini
[ req ]
prompt = no
default_bits       = 2048
distinguished_name = req_distinguished_name
req_extensions     = req_ext
[ req_distinguished_name ]
countryName                 = US
localityName               = Hartland
organizationName           = Example, LLC
commonName                 = *.example.com
[ req_ext ]
subjectAltName = @alt_names
[alt_names]
DNS.1   = *.example.com
DNS.2   = example.com
DNS.2   = ivan.example.com
```

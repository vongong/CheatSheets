# openssl

## Glossary
- `RSA`: This is a widely used public-key cryptography algorithm. By default, generated private keys are often in the "traditional" PKCS#1 format, which can be converted to other formats.
- `PKCS#8`: This is a standard that defines a format for storing private keys for various algorithms, not just RSA
- `PKCS#12`: This standard defines an archive file format (often .pfx or .p12 extensions) that can store a private key along with its associated X.509 certificates in a single, password-protected binary file
- `X.509`: This is an internationally recognized standard for public key certificates. An X.509 certificate binds a public key to an identity (such as a person, organization, or website) and is signed by a Certificate Authority (CA)
- `MD5`: a deprecated cryptographic hash function and is not considered secure for security-related applications like digital signatures or password hashing due to known vulnerabilities

## Links
- [openssl doc cmds](https://docs.openssl.org/master/man1/openssl-cmds/)
 -[How To](https://www.ssl.com/how-to/manually-generate-a-certificate-signing-request-csr-using-openssl/)

## commands
```sh
# Get Version
openssl version

# generate keypair (Some refer as private key, but it contains both)
openssl genrsa -out keyPair.key 2048 # no pass
openssl genrsa -aes256 -passout pass:zzzzz -out keyPair.key 2048 # set pass
openssl rsa -in keyPair.key -check # check
openssl rsa -in keyPair.key -check -passin pass:zzzzz # check with pass

# Export Public Key from keypair
openssl rsa -in keyPair.key -pubout -out public.key

# Create CSR from keypair (see below for san.cnf.txt)
openssl req -new -key keyPair.key -out example.csr # need to fill out info
openssl req -new -key keyPair.key -out example.csr -config san.cnf.txt

# Create CSR and keypair (see below for san.cnf.txt)
openssl req -newkey rsa:2048 -noenc -keyout keyPair.key -out example.csr -config san.cnf.txt
openssl req -in example.csr -noout -text -verify # Check CSR

# self sign cert from keypair
openssl x509 -in example.csr -out example.crt -rep -signkey keyPair.key -days 365

# Get Expire date
openssl x509 -enddate -noout -in file.pem

##############
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

## Info
# Cert
openssl x509 -noout -modulus -in certificate.crt -text
openssl s_client -connect www.example.com:443 | openssl x509 -noout -modulus -text

# Key - rsa
openssl rsa -noout -modulus -in private.key -txt

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
#   -nodes: "no DES" Private Key not encrypted (deprecated use -noenc)
#   -passout: Set password for Key
# Notes: -nodes & -passout conflict. No password will be set
openssl req -newkey rsa:2048 -nodes -keyout "./private.key" -out "./sslcert.csr" -passout pass:zzzzz -config "./san.cnf.txt"

## Create pk12\pfx Certificate from PEM (provided)
openssl pkcs12 -export -out "./Cert.p12" -in "./star_example_com.pem" -inkey "./private.key" -passin pass:zzzzzz -passout pass:zzzzzz

## Create PEM from pk12 Certificate
#  -clcerts: Only output client certificates (not CA certificates).
#  -nokeys: No Private Key Export
openssl pkcs12 -in "./Cert.p12" -out "./newfile.crt.pem" -clcerts -nokeys -passin pass:zzzzzz

## for FTP server ??
# Extract Key from cert (Is it needed? isn't this just the private key)
#  -nocerts: No certificates will be output
openssl pkcs12 -in "./Cert.p12" -nocerts -out "./Cert.key" -passin pass:zzzzzz

# Extract Crt from cert (Is it needed? isn't this just the PEM)
#  -clcerts: Only output client certificates (not CA certificates).
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

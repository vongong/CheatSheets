# OpenSSL Commands and Glossary for RSA Key Management and Certificate Handling

## Info
- **Glossary**
  - `MD5`: a deprecated cryptographic hash function and is not considered secure for security-related applications like digital signatures or password hashing due to known vulnerabilities
  - `Modulus`: large integer, often 2048 or 4096 bits long, that serves as the foundation of RSA cryptography in both public and private keys. In RSA, its the product of 2 prime numbers.
  - `RSA`: This is a widely used public-key cryptography algorithm. By default, generated private keys are often in the "traditional" PKCS#1 format, which can be converted to other formats.
  - `PKCS#8`: This is a standard that defines a format for storing private keys for various algorithms, not just RSA
  - `PKCS#12`: This standard defines an archive file format (often .pfx or .p12 extensions) that can store a private key along with its associated X.509 certificates in a single, password-protected binary file
  - `X.509`: This is an internationally recognized standard for public key certificates. An X.509 certificate binds a public key to an identity (such as a person, organization, or website) and is signed by a Certificate Authority (CA)
- [openssl documentation](https://docs.openssl.org/master/man1/openssl-cmds/)
  - openssl genrsa: Generate RSA Key Pair [Link](https://docs.openssl.org/master/man1/openssl-genrsa/)
  - openssl rsa: Process RSA Keys [Link](https://docs.openssl.org/master/man1/openssl-rsa/)
  - openssl req: Creates and Processes certificate requests (CSRs) in PKCS#10 format [Link](https://docs.openssl.org/master/man1/openssl-req/)
  - openssl pkc12: Created and Parsed PKCS#12 file (sometimes referred to as PFX files) [Link](https://docs.openssl.org/master/man1/openssl-pkcs12/)
  - openssl x509: Certificate display and signing command [Link](https://docs.openssl.org/master/man1/openssl-x509/)

## Commands
```sh
# Get Version
openssl version

# Generate keypair (Some refer as private key, but it contains both)
openssl genrsa -out keyPair.key 2048 # no pass
openssl genrsa -aes256 -passout pass:zzzzz -out keyPair.key 2048 # set pass
openssl rsa -in keyPair.key -check # check
openssl rsa -in keyPair.key -check -passin pass:zzzzz # check with pass

# Encrypt Existing RSA key
openssl genrsa -out your_unencrypted.key 2048
openssl rsa -in your_unencrypted.key -out your_encrypted.key -passout pass:zzzzz
openssl rsa -in your_unencrypted.key -out your_encrypted.key -passout pass:zzzzz -aes256 # Using aes256
openssl rsa -in your_encrypted.key -check -passin pass:zzzzz

# Export Public Key from keypair
openssl rsa -in keyPair.key -pubout -out public.key
openssl rsa -noout -text -inform PEM -in public.key -pubin # Verify Public Key

# Create CSR from keypair (see below for san.cnf.txt)
openssl req -new -key keyPair.key -out example.csr # need to fill out info
openssl req -new -key keyPair.key -out example.csr -config san.cnf.txt

# Create CSR and keypair (see below for san.cnf.txt)
openssl req -newkey rsa:2048 -noenc -keyout keyPair.key -out example.csr -config san.cnf.txt
openssl req -in example.csr -noout -text -verify # Check CSR

# Create Self Sign Certificate - wip
openssl req -x509 -newkey rsa:2048 -nodes -keyout server.key -out server.crt -days 365 -subj "/CN=localhost"
openssl x509 -signkey keyPair.key -in example.csr -req -days 365 -out server.crt # create from keypair and csr

# Get Expire date  - wip
openssl x509 -enddate -noout -in server.crt

# Extract Private Key from PFX/P12
openssl pkcs12 -in "Cert.p12" -nocerts -out "Cert.key" -passin pass:zzzzz -passout pass:zzzzz
openssl pkcs12 -in "Cert.p12" -nocerts -out "Cert.key" -passin pass:zzzzz -noenc # No Encrypt

# Extract PEM from PFX/P12
openssl pkcs12 -in "Cert.p12" -clcerts -nokeys -out "Cert.pem" -passin pass:zzzzz
```

### Verify Key/CSR Base64
- if key is not encrypted, `-----BEGIN PRIVATE KEY-----`
- if key is encrypted, `-----BEGIN ENCRYPTED PRIVATE KEY-----`
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
openssl rsa -noout -modulus -in private.key -text

## Verify a Certificate Chain
openssl verify -CAfile ca_bundle.pem server.crt
```

### -Param `-passin` & `-passout` Options
- pass:*password*: The actual password
- env:*var*: Obtain the password from the environment variable *var*
- file:*filepath*: Reads the password from the specified file pathname. Only the first line, up to the newline character, is read from the stream.
  - **Issue:** Problem using echo. Most likely windows using CRLF (Carriage Return Line Feed `\r\n`) while linux uses LF (Line Feed `\n`).
- stdin: Reads password from Standard Input
 
```sh
# Examples Setup
openssl genrsa -aes256 -passout pass:Hello123 -out keyPair.key 2048
openssl rsa -in keyPair.key -check

# Pass Example
openssl rsa -in keyPair.key -check -passin pass:Hello123

# File Example
printf Hello123 > pass.txt
openssl rsa -in keyPair.key -check -passin file:pass.txt

# Env Example
$env:cert_pass = 'Hello123'
openssl rsa -in keyPair.key -check -passin env:cert_pass
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


## Other Logic - wip
```sh
# Azure Import Cert Logic
cat pkcs12.b64 | base64 -d > pkcs12.bin
openssl pkcs12 -nocerts -passin pass: -in pkcs12.bin -nodes | openssl rsa > priv.pem
openssl pkcs12 -nokeys -clcerts -passin pass: -in pkcs12.bin -nodes | openssl x509 > pub.pem
wget https://certs.godaddy.com/repository/gdig2.crt.pem # Get Intermediate Cert
cat priv.pem pub.pem gdig2.crt.pem > thecert.pem

# split pem
awk 'BEGIN {c=0;} /BEGIN CERTIFICATE/{c++} { print > "cert." c ".pem"}' thecert.pem
```

# openssl

## commands
```sh
###########
# Get Version
openssl version

###########
# OpenSSL command below will generate a 2048-bit RSA private key and CSR 
# https://www.ssl.com/how-to/manually-generate-a-certificate-signing-request-csr-using-openssl/
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
```

## commands from Ryan

```powershell
# Create KeyPair and CSR with Password zzzzz
& 'C:\Program Files\Git\mingw64\bin\openssl.exe' req -out C:\openssl\sslcert.csr -newkey rsa:2048 -nodes -keyout C:\openssl\private.key -passout pass:zzzzz -config C:\openssl\san.cnf.txt

# Create pk12\pfx Certificate from PEM
& 'C:\Program Files\Git\mingw64\bin\openssl.exe' pkcs12 -export -out C:\openssl\Cert.p12 -in C:\openssl\star_batteriesplus_com.pem -inkey C:\openssl\private.key -passin pass:zzzzzz -passout pass:zzzzzz

# Create PEM from pk12 Certificate
& 'C:\Program Files\Git\mingw64\bin\openssl.exe' pkcs12 -in C:\openssl\Cert.p12 -out newfile.crt.pem -clcerts -nokeys -passin pass:zzzzzz

# Split cert to .crt and .key for FTP server
& "C:\Program Files\Git\mingw64\bin\openssl.exe" pkcs12 -in "C:\openssl\Cert.p12" -nocerts -out Cert.key -passin pass:zzzzzz
& "C:\Program Files\Git\mingw64\bin\openssl.exe" pkcs12 -in "C:\openssl\Cert.p12" -clcerts -nokeys -out Cert.crt -passin pass:zzzzzz

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

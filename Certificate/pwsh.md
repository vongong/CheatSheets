# Windows cmds for certs

```powershell
# import pfx into powershell
$x509Certs = New-Object Security.Cryptography.X509Certificates.X509Certificate2Collection
$CertLoc = Get-ChildItem "bpbdevwildcard.pfx"
$x509Certs.Import($CertLoc.FullName, $null, [Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)
$x509Certs | Select-Object Thumbprint, Subject, Issuer | ConvertTo-Json

# Export Private Key
$clCert = $x509Certs | Where-Object HasPrivateKey -eq $true
$privateKey = [System.Security.Cryptography.X509Certificates.RSACertificateExtensions]::GetRSAPrivateKey($clCert)
$keyBytes   = $privateKey.ExportPkcs8PrivateKey()
$base64     = [Convert]::ToBase64String($keyBytes, [Base64FormattingOptions]::InsertLineBreaks)
"-----BEGIN PRIVATE KEY-----`n$base64`n-----END PRIVATE KEY-----"

# Client Cert
$x509Certs | Where-Object HasPrivateKey -eq $true

# CA Certs
$x509Certs | Where-Object HasPrivateKey -eq $false

## Root Cert
$x509Certs | Where-Object HasPrivateKey -eq $false | Where-Object {$_.Subject -eq $_.Issuer}

## Intermediate Cert
$x509Certs | Where-Object HasPrivateKey -eq $false | Where-Object {$_.Subject -ne $_.Issuer}

# Export Cert
$Cert = $x509Certs[0]
$certBytes = $Cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
$base64 = [Convert]::ToBase64String($certBytes, [Base64FormattingOptions]::InsertLineBreaks)
"-----BEGIN CERTIFICATE-----`n$base64`n-----END CERTIFICATE-----"


```
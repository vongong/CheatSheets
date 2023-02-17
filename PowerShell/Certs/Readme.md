
## Self signed
```powershell
$certname = "{certificateName}"    ## Replace {certificateName}
$cert = New-SelfSignedCertificate -Subject "CN=$certname" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256
```

## Get Cert
```powershell
$cert = Get-ChildItem -Path cert:\CurrentUser\My\EEDEF61D4FF6EDBAAD538BB08CCAADDC3EE28FF
```

## Export Cert
```powershell
Export-Certificate -Cert $cert -FilePath "C:\Users\admin\Desktop\$certname.cer"   ## Specify your preferred location
```

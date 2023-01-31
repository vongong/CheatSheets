
## hash
certutil -hashfile "filename.exe" SHA1
certutil -hashfile "filename.exe" SHA256
certutil -hashfile "filename.exe" SHA512
certutil -hashfile "filename.exe" MD5

## copy to clipboard
cat .\filename | clip

## Unlimited LTE Hotspot on PC 
Mangle TTL
```sh
# Windows Commands (run cmd as administrator):
netsh int ipv4 set glob defaultcurhoplimit=65
netsh int ipv6 set glob defaultcurhoplimit=65

# Replace 65 with 128 to reset to default if issues occur on other networks. 
netsh int ipv4 set glob defaultcurhoplimit=128
netsh int ipv6 set glob defaultcurhoplimit=128
```
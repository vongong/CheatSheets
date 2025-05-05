# Azure App Service Troubleshooting

## Console commands

`Tcpping.exe` : This command is similar to ping or psping where you can test if a web app can reach an endpoint via a hostname or IP address or port. If a web app cannot reach an endpoint via hostname it’s always a good idea to test the IP address that corresponds to the hostname in case, there is an issue with the DNS lookup. Tcpping will always default to port 80 unless another port is specified, ie “<hostname or IP address>:port”. For more information about the command and additional switches, type tcpping in the console. Note that the -t and -n switches are best used in Kudu.

**Examples:**
```sh
tcpping google.com
tcpping google.com:80
tcpping 10.0.0.5:443
tcpping google.com:443 -t
```

`Nameresolver.exe`: This command is similar to nslookup where it will do a DNS lookup against the DNS server that is configured for the web app. By default, a standard app service will use Azure DNS. If the app services is configured with VNET integration, this includes both ASE types as well, it will use your custom DNS servers configured for the VNET. To specify a different DNS server to complete the lookup on, add the IP address of the server after the hostname separated by a space, ie. “[hostname] [DNS-Server-IP]”.

**Examples:**
nameresolver google.com
nameresolver google.com 8.8.8.8


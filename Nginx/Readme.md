

## Helpful doc
[link 1](https://github.com/lebinh/nginx-conf)

## install 
- Consider docker instead of local install
- vscode docker extension

## nginx basic
- nginx cmd
  - `-h` : Help
  - `-v` `-V` : Version overview & detailed
  - `-t` `-T` : verify config & detailed Config
- default config: `/etc/nginx/nginx.conf`
- default share: `/usr/share/nginx/html`
- default server config: `/etc/nginx/conf.d/default.conf`
- default error logs: `/var/log/nginx/error.log`
- default access logs: `/var/log/nginx/access.log`

## service basic
`service nginx [cmd]` 
- start: Start Service
- stop: Stop Service
- restart: Restart Service
- reload: Reload Config
- status: Service Status

## architecture
Nginx will spawn master process. Master process will spawn worker processes. procps - can show more details - `ps -C nginx -F`. Request comes into OS, OS distribute request to Worker Process.
- master process
  - start up and shutdown
  - maintain worker process
- worker process
  - process request or serve connections
  - max number of connections 512
  - generally start number of workers process to cpu cores

## Server Static Content
`conf.d/default.conf` - each server for different site
- listen - what port to listen
  - `listen [::]:80;` - for IPv6
- server_name - name of server. can have different server. May need to setup dns locally.
- location - info on static content
  - root - folder for content
  - index - files to server
- error - error pages
```nginx
server {
    listen 80;
    server_name main.com ns.main.com *.main.com;

    location / {
        root /usr/share/nginx/html/main;
        index index.html;
    }
}
```

## Reverse Proxy
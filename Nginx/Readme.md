

## Helpful doc
[link 1](https://github.com/lebinh/nginx-conf)

## install 
https://www.nginx.com/resources/wiki/start/topics/tutorials/install/
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

## Terminology - nginx.conf
- Directive - Key Value pairs
- Context - Block Directive

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
- listen - what port to listen
  - `listen [::]:80;` - for IPv6
- server_name - name of server. can have different server. May need to setup dns locally.
- location - info on static content
  - root - folder for content
  - alias - link to different folder for content
  - index - files to server
  - try_files - list of files it should try
- error - error pages

### MIME types
Context Type. types Defined in http context
```nginx
http {
  types {
    text/css  css;
    text/html  html;
  }
}
```

Nginx has mime types defined in mime.types file. Just include the file
```nginx
http {
  include mime.types;
}
```

Note: Hard reload Ctrl-Shift-r

### location
Allow endpoint to server different content
```nginx
http {
  server {
    listen 80;
    root /Users/user01/mysite;

    location ~* /count/[0-9] {
      root /Users/user01/mysite;
      try_files /index.html =404;
    }

    location /fruits {
      root /Users/user01/mysite;
    }

    location /carbs {
      alias /Users/user01/mysite/fruits;
    }

    location /vegetables {
      root /Users/user01/mysite;
      try_files /vegetables/veggies.html /index.html =404;
    }
    
  }
}
```

## Redirects and Rewrites
crops Redirects
number Rewrite
```nginx
http {
  server {
    listen 80;
    root /Users/user01/mysite;

    location /fruits {
      root /Users/user01/mysite;
    }

    location /crops {
      return 307 /fruits;
    }    
    
    location ~* /count/[0-9] {
      root /Users/user01/mysite;
      try_files /index.html =404;
    }

    rewrite ^/number/(\w+) /count/$1

  }
}
```

## Load Balancer
```nginx
http {
  upstream backendserver {
    server 127.0.0.1:1111;
    server 127.0.0.1:2222;
    server 127.0.0.1:3333;
    server 127.0.0.1:4444;
  }
  server {
    listen 80;
    root /Users/user01/mysite;

    location / {      
      proxy_pass http://backendserver/;
    }

    location /fruits {
      root /Users/user01/mysite;
    }

    location /crops {
      return 307 /fruits;
    }    
    
    location ~* /count/[0-9] {
      root /Users/user01/mysite;
      try_files /index.html =404;
    }

    rewrite ^/number/(\w+) /count/$1

  }
}
```
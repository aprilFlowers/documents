## 更新nginx
  [帮助文档]（https://segmentfault.com/a/1190000006755963#articleHeader6）
#### 实例演习
        #!/bin/bash
        sudo cp /usr/sbin/nginx /usr/sbin/nginx.bak
        wget http://zlib.net/zlib-1.2.11.tar.gz
        tar zxvf zlib-1.2.11.tar.gz
        cd zlib-1.2.11
        ./configure
        make
        make test
        sudo make install
        cd ~
        wget http://nginx.org/download/nginx-1.13.3.tar.gz
        tar zxvf nginx-1.13.3.tar.gz
        cd nginx-1.13.3
        ./configure --prefix=/usr/sbin/nginx
        make
        sudo cp -rfp objs/nginx /usr/sbin/nginx
        nginx -v
        service nginx restart

# WEB服务器常用优化配置

## 系统参数优化
[辅助学习文档]https://wsgzao.github.io/post/sysctl/

### /etc/sysctl.conf配置优化

    #在文件末尾添加如下配置  
    net.ipv4.tcp_tw_reuse = 1
    net.ipv4.tcp_tw_recycle = 1
    net.core.rmem_max = 8388608
    net.core.wmem_max = 8388608
    net.ipv4.tcp_rmem = 4096 87380 8388608
    net.ipv4.tcp_wmem = 4096 87380 8388608
    net.ipv4.tcp_max_syn_backlog = 4096
    net.ipv4.ip_local_port_range = 1024 65000
    net.ipv4.tcp_syn_retries = 2
    net.ipv4.tcp_keepalive_time = 60
    net.ipv4.tcp_keepalive_probes = 4
    net.ipv4.tcp_keepalive_intvl = 15
    net.ipv4.tcp_retries2 = 5
    net.ipv4.tcp_fin_timeout = 30
    net.ipv4.conf.eth0.accept_source_route = 0
    net.ipv4.conf.lo.accept_source_route = 0
    net.ipv4.conf.default.accept_source_route = 0
    net.ipv4.conf.all.accept_source_route = 0
    net.ipv4.conf.eth0.accept_redirects = 0
    net.ipv4.conf.lo.accept_redirects = 0
    net.ipv4.conf.default.accept_redirects = 0
    net.ipv4.conf.all.accept_redirects = 0
    net.ipv4.conf.eth0.secure_redirects = 1
    net.ipv4.conf.lo.secure_redirects = 1
    net.ipv4.conf.default.secure_redirects = 1
    net.ipv4.conf.all.secure_redirects = 1
    net.ipv4.conf.eth0.send_redirects = 0
    net.ipv4.conf.lo.send_redirects = 0
    net.ipv4.conf.default.send_redirects = 0
    net.ipv4.conf.all.send_redirects = 0
    net.ipv4.icmp_echo_ignore_broadcasts = 1
    net.ipv4.icmp_echo_ignore_all = 0
    kernel.core_uses_pid = 1
    kernel.msgmnb = 65536
    kernel.msgmax = 65536
    kernel.shmmax = 68719476736
    kernel.shmall = 4294967296

### /etc/security/limits.conf配置优化

    #在文件末尾添加如下配置
    *        soft   core   1024000
    *        soft   nproc  65535
    *        hard   nproc  65535
    *        soft   nofile  65535
    *        hard   nofile  65535

### 禁用selinux(一个严苛的权限管理，麻烦，冲突)
 编辑文件/etc/sysconfig/selinux 和 /etc/selinux/config，修改SELINUX参数值如下。
SELINUX=disabled

### 禁用ipv6（未推广）
    #echo "options ipv6 disable=1" >> /etc/modprobe.d/dist.conf
    #echo "NETWORKING_IPV6=off" >> /etc/sysconfig/network

## nginx.conf 配置优化
1. [fastcgi 配置优化]https://www.cnblogs.com/yezhaohui/p/4377662.html
1. [更新nginx]（https://segmentfault.com/a/1190000006755963#articleHeader6）

        #默认1，修改为8，
        worker_processes  8;
        #连接数默认1024，修改12500；添加use epoll； 
        events {
          worker_connections  12500;
          use epoll;
        }
        #默认60，修改为15
        keepalive_timeout 15;
        #添加如下配置
        tcp_nopush      on;
        tcp_nodelay     on;
        send_timeout 100;
        fastcgi_connect_timeout 100;
        fastcgi_send_timeout 100;
        fastcgi_read_timeout 100;
        fastcgi_buffer_size 64k;
        fastcgi_buffers 4 64k;
        fastcgi_busy_buffers_size 128k;

1. fastcgi_cache_path是为FastCGI缓存指定一个文件路径、目录结构等级、关键字区域存储时间和非活动删除时间。
1. fastcgi_connect_timeout指定连接到后端FastCGI的超时时间。
1. fastcgi_send_timeout指定向FastCGI传送请求的超时时间，这个值是已经完成两次握手后向FastCGI传送请求的超时时间。
1. fastcgi_read_timeout指定接收FastCGI应答的超时时间，这个值是已经完成两次握手后接收FastCGI应答的超时时间。
1. fastcgi_buffer_size用于指定读取FastCGI应答第一部分需要用多大的缓冲区，这个值表示将使用1个64KB的缓冲区读取应答的第一部分（应答头），可以设置为fastcgi_buffers选项指定的缓冲区大小。
1. fastcgi_buffers指定本地需要用多少和多大的缓冲区来缓冲FastCGI的应答请求。如果一个PHP脚本所产生的页面大小为256KB，那么会为其分配4个64KB的缓冲区来缓存；如果页面大小大于256KB，那么大于256KB的部分会缓存到fastcgi_temp指定的路径中，但是这并不是好方法，因为内存中的数据处理速度要快于硬盘。一般这个值应该为站点中PHP脚本所产生的页面大小的中间值，如果站点大部分脚本所产生的页面大小为256KB，那么可以把这个值设置为“16 16k”、“4 64k”等。
1. fastcgi_busy_buffers_size的默认值是fastcgi_buffers的两倍。
1. fastcgi_temp_file_write_size表示在写入缓存文件时使用多大的数据块，默认值是fastcgi_buffers的两倍。
1. fastcgi_cache表示开启FastCGI缓存并为其指定一个名称。开启缓存非常有用，可以有效降低CPU的负载，并且防止502错误的发生，但是开启缓存也会引起很多问题，要视具体情况而定。
1. fastcgi_cache_valid、fastcgi用来指定应答代码的缓存时间，实例中的值表示将200和302应答缓存一个小时，将301应答缓存1天，其他应答均缓存1分钟。

## php-fpm.conf配置优化
[php-fpm 配置优化]https://www.cnblogs.com/JohnABC/p/4531107.html

        #默认dynamic，改为static（按max配置设置）
        pm = static
        #默认5，改为250，静态方式下有用
        pm.max_children = 250
        #默认2，改为20，动态方式下有用，起始php-fpm进程数量
        pm.start_servers = 20
        #默认1，改为10，动态方式下有用
        pm.min_spare_servers = 10
        #默认3，改为30，动态方式下有用
        pm.max_spare_servers = 30
        #默认500，改为10240
        pm.max_requests = 10240
        #默认1024，改为65536，限制打开文件大小
        rlimit_files = 65536
      
对于内存大的服务器（比如8G以上）来说，指定静态的max_children实际上更为妥当，因为这样不需要进行额外的进程数目控制，会提高效率。因为频繁开关php-fpm进程也会有时滞，所以内存够大的情况下开静态效果会更好。数量也可以根据 内存/30M 得到，比如8GB内存可以设置为100，那么php-fpm耗费的内存就能控制在 2G-3G的样子。如果内存稍微小点，比如1G，那么使用指定动态的进程数量更加有利于服务器的稳定。这样可以保证php-fpm只获取够用的内存，将不多的内存分配给其他应用去使用，会使系统的运行更加畅通。


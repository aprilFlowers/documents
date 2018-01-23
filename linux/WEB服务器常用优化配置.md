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
[fastcgi 配置优化]https://www.cnblogs.com/yezhaohui/p/4377662.html

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

## php-fpm.conf配置优化
[php-fpm 配置优化]https://www.cnblogs.com/JohnABC/p/4531107.html

      #默认dynamic，改为static（按max配置设置）
      pm = static
      #默认5，改为250
      pm.max_children = 250
      #默认2，改为20
      pm.start_servers = 20
      #默认1，改为10
      pm.min_spare_servers = 10
      #默认3，改为30
      pm.max_spare_servers = 30
      #默认500，改为10240
      pm.max_requests = 10240
      #默认1024，改为65536
      rlimit_files = 65536

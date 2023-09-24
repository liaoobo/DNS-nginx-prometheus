#!/bin/bash

#新建文件夹存放nginx源码包
mkdir -p /nginx
cd /nginx

# 下载nginx压缩包
curl -O http://nginx.org/download/nginx-1.25.2.tar.gz
# 或者用wget
#wget http://nginx.org/download/nginx-1.25.2.tar.gz
# 解压
tar xf nginx-1.25.2.tar.gz
# 进入文件夹
cd nginx-1.25.2

# 新建用户,用于启动nginx进程，名字自拟
useradd -s /sbin/nologin liaobo

# 安装依赖包
# ssh相关、gcc为编译需要、pcre正则相关、make编译相关
yum install -y epel-release openssl openssl-devel gcc pcre pcre-devel automake make net-tools vim

# configure是一个配置的脚本文件，会根据指定的配置生成一个Makefile文件，这个文件会影响后面make命令的编译，相当于图纸
# configure可配置参数可以参考官方文档：http://nginx.org/en/docs/configure.html
# 常用选项：
# --with-*：开启某个功能，默认不安装	--without-*：禁用某个功能，默认安装
# --prefix=path：指定路径			--conf-path=path：指定配置文件路径,不指定会放到prefix路径下
# --user=name：指定启动nginx worker进程的用户
# --with-http_ssl_moudle 开启https的功能，下载ssl来进行公钥和私钥的认证
# --without-http——memcached_moudle 禁用http_memcached
# --with-http_realip_module 启用realip功能，让后端知道通过代理访问的用户的ip
# --with-http_v2_module：对http2.0版本的支持
# --with-threads：开启线程池功能		--with-http_stub_status_moudle：开启nginx状态统计功能，可以知道多少访问
# --with-stream 支持tcp/udp反向代理，即4层负载均衡
./configure --prefix=/usr/local/nginx --user=liaobo --with-http_ssl_module --with-http_realip_module --with-http_v2_module --with-threads --with-http_stub_status_module --with-stream

#编译，开启2个进程同时编译
make -j 2

#安装
make install

#启动nginx
/usr/local/nginx/sbin/nginx
#修改PATH变量
PATH=$PATH:/usr/local/nginx/sbin
echo "PATH=$PATH:/usr/local/nginx/sbin" >>/root/.bashrc

#设置nginx的开机启动
echo "/usr/local/nginx/sbin/nginx" >>/etc/rc.local
chmod +x /etc/rc.d/rc.local

#selinux和firewalld防火墙都关闭
service firewalld stop
systemctl disable firewalld

#临时关闭selinux
setenforce 0
sed -i '/^SELINUX=/ s/enforcing/disabled/' /etc/selinux/config

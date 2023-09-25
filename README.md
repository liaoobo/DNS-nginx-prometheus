# 基于DNS+nginx+prometheus的双vip高可用Web集群

## 1.拓扑图

![在这里插入图片描述](https://img-blog.csdnimg.cn/c9d191ae20a24eeaa9bc625cc47a112c.png#pic_center)



## 2.详细介绍

项目名称：基于 DNS+nginx+prometheus 的双 vip 高可用 Web 集群

项目环境：CentOS 7.9.2009，Nginx 1.25.2，keepalived 1.3.5，ansible 2.9.27，Prometheus，Grafana，NFS等

项目描述：模拟企业构建一个高可用并且高性能的web集群项目，能处理大并发的web业务。使用Ansible实现软件环境的部署，Nginx实现7层负载均衡和搭建web框架，keepalived搭建双vip双master高可用架构，Prometheus+Grafana实现对web集群以及负载均衡器的系统资源监控,NFS实现web集群的数据同源，DNS搭建域名服务器实现对双vip地址进行解析。

项目步骤：

    1.准备10台全新虚拟机，提前规划好ip并建立免密通道，使用Ansible自动化批量部署nginx软件环境
    
    2.在两台nginx7层负载均衡器上使用keepalived搭建双vip双master高可用架构，并使用健康检测监控本机nginx进程，后端Web集群通过NFS服务器实现网页数据同源
  
    3.搭建DNS域名服务器，增添两条负载均衡记录，实现基于DNS的负载均衡，访问同一URL解析出双vip地址
  
    4.安装部署prometheus+grafana实现对Web服务器和load balance服务器的监控和出图
  
    5.ab测试机对web集群和负载均衡器进行压力测试，了解系统性能的瓶颈，对系统性能资源(如内核参数、nginx参数 )进行调优，提升系统性能

项目心得：

    1.提前规划好整个集群的架构，可以提高项目开展时效率
  
    2.对基于Nginx的web集群和高可用、高性能有了深入的理解，同时对脑裂和vip漂移现象也有了更加深刻的体会和分析。
  
    3.加强了对7层负载均衡和dns负载均衡的认识
  
    4.认识到了系统性能资源的重要性，对压力测试下整个集群的瓶颈有了一个整体概念

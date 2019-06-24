#  网络工程部署与实施综合实践(Day1)  
>网络部署实施课程的第一天，实现的是基于SDvpn的隧道之间相互通信。

网络拓扑：
![image.png](pictures/zcsf7gtb7if.png)
红笔标出的IP是各机器端口的IP
红笔画的是隧道的创建以及其网段
## 网络规划与设计

配置各个端口的IP地址
配置底层的EIGRP协议
配置DMVPM隧道，使得分部内网与总部进行通信
配置IP SEC协议，使移动终端与总部进行通信

## 网络部署与实施
配置路由器与交换机端口的IP  
R1
![image.png](pictures/i7b4qc7qh7g.png)

R2  
![image.png](pictures/1jwonc2e78m.png)
R3  
![image.png](pictures/7zx33mpift6.png)
R4  
![image.png](pictures/yo25gdtt5sr.png)
交换机SW1  
![image.png](pictures/askxed4069.png)
交换机SW2  
![image.png](pictures/qq7jtvqh84.png)

防火墙  
![image.png](pictures/cpximpw0dql.png)
## 建立隧道
R1
![image.png](pictures/hjemhbvo7k.png)


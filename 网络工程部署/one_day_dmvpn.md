#  网络工程部署与实施综合实践(Day1)  
>网络部署实施课程的第一天，实现的是基于SDvpn的隧道之间相互通信。

网络拓扑：
![image.png](pictures/zcsf7gtb7if.png)
红笔标出的IP是各机器端口的IP
红笔画的是隧道的创建以及其网段
## 网络规划与设计

本质就是使用IP sec使得外网终端能够与总部内网进行通信；使用DMvpn技术使得，分部内网能够与总部进行通信；使用EIGRP使得不同内网能够互相通信

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
R1建立隧道  
![image.png](pictures/hjemhbvo7k.png)
R2的隧道建立  
![image.png](pictures/5nxdgzmqez9.png)
 
R3的隧道建立：
![image.png](pictures/5mfwlcx19d8.png)
R4的隧道建立
![image.png](pictures/4pd5ydt63we.png)
建立隧道的结果：
R1
![image.png](pictures/hfyxi43gy2.png)
R2
![image.png](pictures/jgyze4b8fq.png)
R3
![image.png](pictures/kyooap2exxt.png)
R4
![image.png](pictures/ykmriua12d.png)
## 配置ERGRP协议
R1
![image.png](pictures/t94auzjkpu.png)
R2
![image.png](pictures/rhhlvz2786.png)
R3
![image.png](pictures/d2pgt8maop.png)
R4
![image.png](pictures/eggfki3hzsc.png)
## 配置IP sec协议
![image.png](pictures/8kwwequqtjf.png)


```{.python .input}

```

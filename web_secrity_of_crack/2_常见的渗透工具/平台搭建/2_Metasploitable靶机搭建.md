>什么是Metasploitable?Metasploitable虚拟系统是一 个特别制作的 Ubuntu操作系统,主要用于安全工具测试和演示常见的
漏洞攻击,也就是我们常说的linux靶机.

我们将会使用docker安装Metasploitable.

## docker配置一个自己的网络

```
docker network create --subnet=172.18.0.0/16 mynetwork
```


结果本机网络上多了一张网卡
![image.png](http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/zo3bcyejfgl.png)


## Metasploitable容器安装
### 查询有哪些Metasploitable镜像
![image.png](http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/4zsjib33rli.png)
### 选择其中的一个镜像下载

```shell
dcker pull tleemcjr/metasploitable2
```


### 实例化容器

```shell
docker run -itd --name metasploitable2   --net mynetwork --ip 172.18.0.2 tleemcjr/metasploitable2
```


查看容器状态
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/8nffsdux2cr.png" width="600px" />
此时容器状态为停止,只要docker start 容器名 即可启动容器

### 进入容器,查看ip
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/bj00xnzgfzk.png" width="300px" />
靶机已经搭建完成

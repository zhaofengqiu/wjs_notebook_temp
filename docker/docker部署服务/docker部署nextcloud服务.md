## 更新仓库
有很多软件位于 EPEL 仓库中, 而默认情况下安装的 CentOS 中没有该仓库, 因此需要自己手动添加.
```shell
 yum -y install epel-release
 yum -y update
```

## 安装apache2
```shell
yum install httpd -y
```  
启动httpd服务 
```shell
systemctl start httpd
```
查看httpd服务状态  

<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/vxa0gfyatq.png" width="600px" />  

让httpd服务开机启动
```shell
systemctl enable httpd
```

## 安装mysql服务


```{.python .input}

```

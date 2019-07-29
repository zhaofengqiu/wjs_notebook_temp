## 更新仓库
有很多软件位于 EPEL 仓库中, 而默认情况下安装的 CentOS 中没有该仓库, 因此需要自己手动添加.
```shell
 yum -y install epel-release
  yum -y update
```

## 安装service服务
```
yum install initscripts -y
```
## 安装apache2
```shell
 yum info httpd
 yum -y install httpd 
  yum -y install apache2
```

```{.python .input}

```

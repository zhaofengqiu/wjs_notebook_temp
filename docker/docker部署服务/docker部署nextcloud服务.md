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

## 安装和配置MySQL
首先需要安装wget服务
```shell
yum install wget
```
这里选择安装MySQL5.7，也可以到[官网](https://dev.mysql.com/downloads/repo/yum/)下载最新或者选择合适的版本。
1. 下载mysql
```shell
[root@eed91f779df8 /]# cd
[root@eed91f779df8 ~]# ls
anaconda-ks.cfg
[root@eed91f779df8 ~]# pwd
/root
[root@eed91f779df8 ~]# mkdir mysql
[root@eed91f779df8 mysql]# wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
```

2. 安装MySQL源  
```shell
[root@eed91f779df8 mysql]#  rpm -ivh mysql57-community-release-el7-8.noarch.rpm
warning: mysql57-community-release-el7-8.noarch.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
Preparing...                          ################################# [100%]
Updating / installing...
   1:mysql57-community-release-el7-8  ################################# [100%]
[root@eed91f779df8 mysql]# 1
bash: 1: command not found
[root@eed91f779df8 mysql]#  rpm -ivh mysql57-community-release-el7-8.noarch.rpm
warning: mysql57-community-release-el7-8.noarch.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
Preparing...                          ################################# [100%]
	package mysql57-community-release-el7-8.noarch is already installed
[root@eed91f779df8 mysql]#  rpm -ivh mysql57-community-release-el7-8.noarch.rpm
warning: mysql57-community-release-el7-8.noarch.rpm: Header V3 DSA/SHA1 Signature, key ID 5072e1f5: NOKEY
Preparing...                          ################################# [100%]
	package mysql57-community-release-el7-8.noarch is already installed

```

3. 检查MySQL源是否安装成功
```shell
[root@eed91f779df8 mysql]# yum repolist enabled |grep mysql
mysql-connectors-community/x86_64 MySQL Connectors Community                118
mysql-tools-community/x86_64      MySQL Tools Community                      95
mysql57-community/x86_64          MySQL 5.7 Community Server                364
```
4. 安装
```
[root@eed91f779df8 mysql]# yum install mysql-community-server
```

```{.python .input}

```

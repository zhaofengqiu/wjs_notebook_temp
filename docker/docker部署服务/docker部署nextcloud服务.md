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
4. 安装mysql-community-server
```
[root@eed91f779df8 mysql]# yum install mysql-community-server
```
有点大,所以安装时间有点长.需要耐性等待
5. 启动mysqld服务
```shell
[root@eed91f779df8 mysql]# systemctl start mysqld
```
第一次启动时间可能比较长，一定要耐心等待。
6. 检查mysqld服务是否启动
```shell
[root@eed91f779df8 mysql]# systemctl status mysqld
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2019-07-29 02:39:03 UTC; 6s ago
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html
  Process: 4093 ExecStart=/usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid $MYSQLD_OPTS (code=exited, status=0/SUCCESS)
  Process: 4022 ExecStartPre=/usr/bin/mysqld_pre_systemd (code=exited, status=0/SUCCESS)
 Main PID: 4095 (mysqld)
   CGroup: /docker/eed91f779df83efe665fd529a0a51921e4ad943f340d202ff6e1a969bd8d3f56/docker/eed91f779df83efe665fd529a0a51921e4ad943f340d202ff6e1a969bd8d3f56/system.slice/mysqld.service
           └─4095 /usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/my...
           ‣ 4095 /usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/my...
Jul 29 02:38:37 eed91f779df8 systemd[1]: Starting MySQL Server...
Jul 29 02:39:03 eed91f779df8 systemd[1]: Started MySQL Server.
```
7. mysqld开机启动
```
[root@eed91f779df8 mysql]# systemctl enable mysqld
```
8. 修改root本地登录密码  
mysql安装完成之后，在/var/log/mysqld.log文件中给root生成了一个默认密码。通过下面的方式找到root默认密码，然后登录mysql进行修改：
查看密码  
```shell
[root@eed91f779df8 mysql]# grep 'temporary password' /var/log/mysqld.log
2019-07-29T02:38:39.780084Z 1 [Note] A temporary password is generated for root@localhost: /Yn4#pui?uwy
```



修改密码
```
[root@eed91f779df8 mysql]# mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.7.27

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> ALTER USER root@localhost IDENTIFIED BY 'Sqlwjs123.';
Query OK, 0 rows affected (0.00 sec)

mysql> 

```

**注意：mysql5.7默认安装了密码安全检查插件（validate_password），默认密码检查策略要求密码必须包含：大小写字母、数字和特殊符号，并且长度不能少于8位。否则会提示ERROR 1819 (HY000): Your password does not satisfy the current policy requirements错误.**

## 安装PHP
添加 Webtatic 仓库php7-fpm 依赖需要
```
[root@eed91f779df8 mysql]# rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```

安装 PHP7-FPM
```
[root@eed91f779df8 mysql]# yum -y install php70w-fpm php70w-cli php70w-gd php70w-mcrypt php70w-mysql php70w-pear php70w-xml php70w-mbstring php70w-pdo php70w-json php70w-pecl-apcu php70w-pecl-apcu-devel

```

## nextcloud下载
1. 安装解压工具
```
yum install unzip
```

2. 下载Nextcloud
```
wget -P /tmp https://download.nextcloud.com/server/releases/nextcloud-15.0.0.zip
```

```{.python .input}

```

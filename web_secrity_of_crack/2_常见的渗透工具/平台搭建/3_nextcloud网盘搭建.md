>还是与之前一样使用docker搭建服务

## 创建容器

## 更新源
```shell
yum -y update
```
### 添加 epel 仓库
有很多软件位于 EPEL 仓库中, 而默认情况下安装的 CentOS 中没有该仓库, 因此需要自己手动添加.
```shell
yum -y install epel-release
```

### 添加 Webtatic 仓库
php7-fpm 依赖需要
```shell
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
```

[https://www.jianshu.com/p/c57a678b50c3](https://www.jianshu.com/p/c57a678b50c3)

[https://www.jianshu.com/p/e2574f7f2dc5?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation](https://www.jianshu.com/p/e2574f7f2dc5?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)

```{.python .input}

```

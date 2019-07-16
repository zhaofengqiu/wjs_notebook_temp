## 堆叠查询
堆叠查询就是指可以执行多条语句，多语句之间以分号隔开。即第一条语句是系统自己的语句，当系统执行完自己的sql语句的时候，就会执行第二条语句，而这条语句则是我们的注入语句。这样子数据库就执行了我们自己的sql语句。
如：

```sql
'; select if(substr(user,1,1)='r',sleep(5),1)%23
```


1. 利用堆叠注入获取数据
```sql
';select if(substr((select table_name from information_schema.tables where table_schma=database() limit 0,1),1,1)='e',sleep(5),1)%23
```


## 二次注入攻击
这个过程是比较复杂的，即整个注入过程是靠两次注入实现的。下面举几个例子。
1. 完整的select * from user语句分为两步分。第一步，注册的时候用户名写入select * from ，注册成功后。第二部分，查询用户的时候，用户名查询使用user 。这样子就会拼接成一条sql查询语句，从而实现在数据库内部实现sql查询。
2. 注册的时候，用户名填写test`,这样子在查询用户的时候。就会报错。爆出一个数据库错误。

所以二次注入攻击的完整过程是通过两次攻击一起整合到一次，从而绕过过滤。
<img src="../pictures/y90dwbo69n.png" width="400" />

## 宽字符注入
>zheng'du

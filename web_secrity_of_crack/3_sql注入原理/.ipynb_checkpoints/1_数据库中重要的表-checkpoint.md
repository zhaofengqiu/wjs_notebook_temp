## mysql数据库
### information_ schema数据库
>这个数据库中存放着是整个mysql相关的表

1.  information_ schema.SCHEMATA  
存储该用户创建的所有数据库的库名,
```mysql
SELECT SCHEMATA_NAME FROM information_ schema.SCHEMATA  
```
这条语句是获取数据库中创建的所有数据库
2.  information_ schema.TABLES 

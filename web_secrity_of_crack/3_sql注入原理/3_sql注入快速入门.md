## Union注入攻击
### 判断字段长度
使用order by num。其中num指的就是第几列，由于不存在第几行就会报错。比如 order by 4，这个就是指的是按照第四列排序，如果不存在第四行就会报错
### 判断相关字段类型
使用order by num 可以获取到有几列数据，现在就要获取到每列数据的数据类型。比如上面获取到的是四列数据。则这里就是用
```sql
union select 1,2,3,4 
```
看返回的是哪个数字就可以确认对应的列是可以返回数据的。
### 获取数据
已经获取到了4列数据，并且确认返回的是3，即
```sql
union select 1,2,3,4 
```
返回的是3则说明第三列可以存放变量的。
使用
1. 获取数据库
```sql
id=1 union select 1,2,database(),4
```
成功返回当前使用的数据库，返回的是sql
2. 获取表
```sql
    unioon select 1,2,(select table_name from information_schema.tables table_name='sql' limit 0,1),4
```

成功获取返回得到数据表，返回的是emails

```{.python .input}

```

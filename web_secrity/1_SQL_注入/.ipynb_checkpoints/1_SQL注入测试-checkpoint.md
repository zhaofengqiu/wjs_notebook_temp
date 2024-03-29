## sql注入测试的目的  

查找可疑注入点集合，确定可用注入点

## sql注入点可能存在的地方  

只要与数据库发生了交互，就可能出现注入点，比如get请求、post请求、cookie和http报文的头部信息，以及DNS查询都可以出现  
    
## 进行推理测试注入点  
+ 识别数据输入
		查看那些输入点可能会产生注入点
+ 操纵参数
		构建参数，来尝试是否会产生注入点
+ 信息工作流
		查看服务器给出的响应
### 思考问题
为什么会有数据库报错显示到页面?   
web服务器只负责创建SQL查询，解析结果，将结果显示给用户。将数据库产生的错误直接打印到前端，是由于两个原因:
+ 没有进行过滤——sql非法字符过滤
+ 没有进行过滤——报错过滤
<img src="../pictures/m8cf6bz1caa.png" width="600" />  



## 常见的SQL错误
### SQL Server错误
1. 将一个单引号插入到参数中会产生数据库错误。
2. 应该是数值形的，却输入字符。会导致数据库，认为字符是列名
3. 转换类型失败，暴露变量内容：如0/@@version。中@@version是MSSQL的全局变量，0/@@versio .类型转换失败，所以就将@@versio数据库信息暴露出来。
4. 显示数据库执行的语句的信息
5. 使用Group By来枚举select语句中的所有列  

### Mysql 错误
1. 将一个单引号插入到参数中会产生数据库错误。
+ 应该是数值形的，却输入字符。会导致数据库，认为字符是列名。  

### Oracle错误
1. 将一个单引号插入到参数中会产生数据库错误。  
1. 应用程序的响应  
    + 我们可以通过用户分析，输入分析web/应用程序的响应
        1. 常见错误  
返回默认服务器的出错页面，这个是不会将数据库的报错暴露在网页上的  

        2. HTTP状态码异常  
返回不寻常的http状态码，比如302和500.收到302或者500是个好事情，说明我们已经以某种方式干预了程序的正常运行



## 确定sql注入点
当识别处异常后，我们需要操作用户数据输入并且分析服务器响应来确定注入点，即构造出一条有效的SQL语句来确定SQL注入漏洞
### 数据类型  
首先，由于我们是要查看漏洞点是否能被我们利用，所以我们的目的不在于使得服务器返回异常，而是需要让我们构造的sql语句被正常执行，这也就意味着，我们构造的sql语句一定要是正确的，即控制好语句的闭合，如果语句没有单引号闭合好，那么就会报错。以下是不同数据类型的正确构造  
数字：不需要使用单引号来构造；  
其他类型：需要使用单引号来表示；
### 内联SQL注入
内联注入是指向查询注入一些sql代码后，原来的查询仍然会被全部执行。就是构造sql语句  
字符串内联构造注入  
下面有个例子，原来的sql语句
```sql      
select *
From administrators
where username = '[USER ENTRY]' and PASSWORD = '[USER ENTRY]';
```
内联注入（对账号）
```sql
select *
From administrators
where[ (username = '[USER ENTRY]')  or '1=1] or (1' ='1' and PASSWORD = '[USER ENTRY]';) 
```
这样子构造就会成为一个永真语句。即账号输入 [USER ENTRY]  or '1=1 or 1' ='1' 
内联注入（对密码）
```sql
select *
From administrators
where (username = '[USER ENTRY]' and PASSWORD = '[USER ENTRY]' ) or '1'='1';
```
这样子也构造出了永真语句。对于这题来说，内联注入就是构造一条使得where永真的语句字符串内联注入的特征值

### 数字形内联注入  
与字符型不一样的地方在于，不需要使用单引号，同时也可以用式子来表示  
<img src="../pictures/1myxq309ba1.png" width="600" />  

### 终止式sql注入  

1. 使用注释代替空格
<img src="../pictures/hiti6sxaaqm.png" width="600" />
+2. 使用注释终止sql语句  
使用注释，可以很好的终止一部分原sql语句。我们可以很好的看到and password=' '被注释终止掉了。有哪些注释特征值
<img src="../pictures/okx5fy81oog.png" width="600" />
<img src="../pictures/tp8xwgz4ktm.png" width="600" />
<img src="../pictures/rf2r6jaz2us.png" width="600" />
3. 执行多条语句  
我们可以通过执行多条语句来执行updata语句，即第一条是应用程序的查询语句，第二条就是updata语句  
<img src="../pictures/pylq1wrjoaf.png" width="600" />  

### 时间盲注  
我们可以向数据库注入时间延迟，查看服务器的响应是否已经产生了延迟。web服务器虽然可以隐藏错误或者数据，但必须等待数据库返回结果。因此可以用它来确认是否存在sql注入漏洞
1. SQL Server时间注入漏洞  
    waitfor delay 'hours:minutes:seconds'如：  
<img src="../pictures/3100uscfqm8.png" width="600" />  

2. Mysql
<img src="../pictures/ej0x1ggfle.png" width="600" />  

3. Oracle 数据库
<img src="../pictures/px3ww215jxr.png" width="600" />  

4. PostgreSQL数据库  
    使用pg_sleep（）函数  
<img src="../pictures/b7tx2um2xvt.png" width="600" />


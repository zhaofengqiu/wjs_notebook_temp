## UNION正常工作的条件
1. 需满足下列
    + 两个查询返回的列数必须相同。
    + 两个SELECT语句对应列所返回的数据类型必须相同（或至少是兼容的）。  
如下面这个例子
<img src="../pictures/yuhd2ry5zu.png" width="600" />
其中的N是相同的，而且提取出来的column也要类型相同，否则就会报错提取不出来。  
### 那么我们如何获取列数？
我们可以使用order by index。其中index就是表示按照第几行排序。  
如果不满足就会报错。比如:  

```
http：//www.vitcom.com/products·asp?id=12+order+by+2
```
如果报错，那么就表示第一个查询语句得到的列只有两行
### 那么我们如何获取每列所对应的数据类型？
通过order by 获取了查询得到的有几列，现在是时候选择其中的一列或几列来查看一下是否是正在寻找的数据了。前面提到过，对应列的数据类型必须是相互兼容的。因此， 如果想提取一个字符串值（例如，当前的数据库用户），那么至少需要找到一个数据类型为字符串的列以便通过它来存储正在寻找的数据。使用NULL来实现会很容易，只需一次一列地使用示例字符串替换NULL即可。例如，如果发现原始查询包含4列，那么应尝试下列URL：
<img src="../pictures/0v0dpei1jaoa.png" width="600" />

只要应用程序不返回错误，即可知道刚才存储test值的列可以保存一个字符串，因而可用它来显示需要的值。例如，如果第二列能够保存一个字符串字段（假设想获取当前用户的名称），只需请求下列URL：
<img src="../pictures/8hl8v6avnd.png" width="600" />

### 获取到列数和对于的数据类型的时候，我们就可以来获取数据了。
1. 我们可以添加内置变量来获取数据
<img src="../pictures/d85avo4rk3.png" width="600" />  

其中db_name()就是sql内置变量

2. 我们可以使用表来获取数据
<img src="../pictures/urqdmffyzgj.png" width="600" /> 

3. web应用对输出有限制
    + 比如php做出了限制，要求只能显示第一行数据，我们该怎办？
    用and 1=0 移除原有查询
<img src="../pictures/9d4typmba4.png" width="600" />  

    + 使用and 1=0 以及userid >1 移除掉原有查询和第一行数据  
<img src="../pictures/mnzk251zfc.png" width="600" />  

    + 可以通过逐渐增大userid参数的值来循环地遍历整张表

```{.python .input}

```

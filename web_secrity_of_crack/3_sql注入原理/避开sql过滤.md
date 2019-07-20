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



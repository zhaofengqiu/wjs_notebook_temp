## 大小写混合
在规则匹配时只针对了特定大写或特定小写的情况，在实战中可以通过混合大 小写的方式进行绕过 （现在几乎没有这样的情况）， 如下所示.
```sql
uNiOn SeLect 1,2,3,4,5
```
## URL编码方式
极少部分的WAF不会对普通字符进行URL解码
```sql
union select 1,2,3,4,5
```
%75%6E%69%6F%6E%20%73%65%6C%65%63%74%20%31%2C%32%2C%33%2C%34%2C%35
还有一种情况就是URL二次编码， WAF一般只进行一次解码， 而如果目标 Web系统的代码中进行了额外的URL解码，即可进行绕过。
## 替换关键字
WAF采用替换或者删除select/union这类敏感关键词的时候，如果只匹配一次则很容易进行绕过。

```sql
union select 1,2,3,4,5
```
转换成
```sql
ununionion seselectlect 1,2,3,4,5
```
这样子正是因为被替换掉后，才会真正的执行.
## 使用注释
使用注释替代空格
<img src="../pictures/mudfgj5h6mr.png" width="600" />

## 多参数请求拆分
对于多个参数拼接到同一条SQU吾句中的情况，可以将注入语句分割插入。
<img src="../pictures/du3njayefvg.png" width="600" />
<img src="../pictures/urimemhlui9.png" width="600" />

## 注入参数到 cookies中


```{.python .input}

```

题目：[http://web16.buuoj.cn/](http://web16.buuoj.cn/)

## 测试注入点

<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/l95xmk6vhr.png" width="600px" />
可以看出两件事情：
1. 存在注入点
2. 有报错显示，可以进行报错注入

## 测试有表有几列
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/k7b9pkxupnc.png" width="600px" />

## 测试select

<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/og0nm7skwmk.png" width="600px" />
可以看出存在这个过滤 

``` 
return preg_match("/select|update|delete|drop|insert|where|\./i",$inject);
```



## 绕过过滤
### 测试能否进行堆叠查询
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/y4ld12thvpk.png" width="600px" />
可以进行迭代查询

### 使用extractvalue函数绕过过滤
这里如果一定要使用select，那么就需要在前台将select拆成两部分，在后台合并然后执行该字符串。
整个过程可以表述为：
+ 使用concat拆分select；
+ 使用存储过程执行字符串；

#### 查询当前数据库版本
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/k5obgvs03oh.png" width="600px" />

#### 查询当前是属于哪个数据库
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/tos36bp1iro.png" width="600px" />

#### 使用堆叠查询，查询当前数据库有几张表
```sql
set @sql1=concat('show',' tables');
prepare stmt from @sql1;
execute stmt;
```
注意点就是mysql没有双引号，所以concat中需要使用单引号。同时从运行结果可以知道，一共存在两张表
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/db3th3vdzn9.png" width="600px" />

#### 使用堆叠查询，查询表的字段
1. 查询1919810931114514


#### 使用报错注入获取数据库的名称


```{.python .input}

```

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
### 测试能否进行迭代查询
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/y4ld12thvpk.png" width="600px" />
可以进行迭代查询

### 使用extractvalue函数绕过过滤
这里如果一定要使用select，那么就需要在前台将select拆成两部分，在后台合并然后执行该字符串。
整个过程可以表述两种方法：
1. 第一种方法
    + 使用concat拆分select；
    + 使用extractvalue来进行执行字符串

2. 第二种方法
    + 使用concat拆分select；
    + 使用存储过程执行字符串；

两种方法之间的区别是，前可以通过内联sql注入拼接成一条sql注入语句。第二种方法，则一定需要执行多条sql语句。
### 
#### 使用报错注入获取数据库的名称


```{.python .input}

```

弱类型&&MD5函数特性
====


## 源码
```php
if (isset($_GET['a']) and isset($_GET['b'])) { 
if ($_GET['a'] != $_GET['b'])</br>
    	if (md5($_GET['a']) == md5($_GET['b'])) 
        	die('Flag: '.$flag);</br>
    else 
        print 'Wrong.'; 
} 
```

## 源码解析
a与b参数需要有值。并且a与b不想等。但是a的md5与b的md5相同。

##  弱类型
即MD5后的结果为0e开头。而php是弱语言，所以在使用运算符进行判断的时候就会将其判断为0.所以只要找一个md5之后任然是0e开头的就能够使其相同。
构造  
a=240610708  
b=QNKCDZO  

## MD5函数特性
md5(array)的值为空，所以另一种解法为：index.php?a[]=&b[]=1


```{.python .input}

```

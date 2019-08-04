## 题目
题目来源：[http://chinalover.sinaapp.com/web23/](http://chinalover.sinaapp.com/web23/)

## 源码阅读
源码

```php

<!--$file = $_GET['file'];
if(@file_get_contents($file) == "meizijiu"){
    echo $nctf;
}-->
```


## 解题
这里使用了file_get_contents。这个函数是用于将文件的内容读入到一个字符串中的首选方法。使用php://input伪协议。

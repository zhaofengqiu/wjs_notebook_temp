%00截断
====

题目来源[http://teamxlc.sinaapp.com/web4/f5a14f5e6e3453b78cd73899bad98d53/index.php](http://teamxlc.sinaapp.com/web4/f5a14f5e6e3453b78cd73899bad98d53/index.php)

## 源码
```php
if (isset ($_GET['nctf'])) {
        if (@ereg ("^[1-9]+$", $_GET['nctf']) === FALSE)
            echo '必须输入数字才行';
        else if (strpos ($_GET['nctf'], '#biubiubiu') !== FALSE)   
            die('Flag: '.$flag);
        else
            echo '骚年，继续努力吧啊~';
    }
```

简单的来说 代码要求就是：
1. 输入的字符串必须全部是数字
2. 字符串中必须包含#biubiubiu



### %00截断

不是应该相矛盾吗？但是其实这里又涉及到了php对字符串的处理。即 PHP的00截断，就是php将请求中的参数存放在变量中的时候，遇到%00的时候就会自动截断参数，不将%00后面的参数内容存放在变量中。
构造一个字符串1%00%23biubiubiu
即可获取结果
flag:nctf{use_00_to_jieduan}

### 利用ereg和strpos函数处理数组的特性


## sqlmap
### sqlmap入门
1. 判断是否存在注入点
```
sqlmap -u http://xxx
```
当参数有多个时，需要加双引号
```
sqlmap -u "http://xxx/?id=1&uid=2"
```
2. 判断http报文中是否存在注入点
将http报文写入一个文本，然后使用```


```{.python .input}

```

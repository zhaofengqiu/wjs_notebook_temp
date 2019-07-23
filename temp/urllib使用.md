>urllib包含的模块以及其作用
1. urllib.request 请求模块
2. urllib.error 异常处理模块
3. urllib.parse url解析模块
4. urllib.robotparser robots.txt解析模块

## request普通请求
### GET请求
```python
import urllib.request
response = urllib.request.urlopen('http://www.baidu.com')
print(response.read().decode('utf-8'))
```

### POST请求
```python
import urllib.parse
import urllib.request
data = bytes(urllib.parse.urlencode({'word': 'hello'}), encoding='utf8')
response = urllib.request.urlopen('http://httpbin.org/post', data=data)
print(response.read())
```

### timeout参数
请求设置一个超时时间，如果超过这个世间，那么将会报错
```PYTHON
import urllib.request

response = urllib.request.urlopen('http://httpbin.org/get', timeout=1)
print(response.read())

```

### 对异常进行捕获
```PYTHON
import socket
import urllib.request
import urllib.error

try:
    response = urllib.request.urlopen('http://httpbin.org/get', timeout=0.1)
except urllib.error.URLError as e:
    if isinstance(e.reason, socket.timeout):
        print('TIME OUT')
```



## request进阶请求
### 添加headers


## 响应
响应类型、状态码、响应头
```python
import urllib.request
response = urllib.request.urlopen('https://www.python.org')
print(type(response))
```
我们可以通过response.status、response.getheaders().response.getheader("server")，获取状态码以及头部信息
response.read()获得的是响应体的内容


```{.python .input}

```

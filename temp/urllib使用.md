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
#### 第一种方式

```PYTHON
from urllib import request, parse

url = 'http://httpbin.org/post'
headers = {
    'User-Agent': 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)',
    'Host': 'httpbin.org'
}
dict = {
    'name': 'zhaofan'
}
data = bytes(parse.urlencode(dict), encoding='utf8')
req = request.Request(url=url, data=data, headers=headers, method='POST')
response = request.urlopen(req)
print(response.read().decode('utf-8'))
```


#### 第二种方式

```python
from urllib import request, parse

url = 'http://httpbin.org/post'
dict = {
    'name': 'Germey'
}
data = bytes(parse.urlencode(dict), encoding='utf8')
req = request.Request(url=url, data=data, method='POST')
req.add_header('User-Agent', 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)')
response = request.urlopen(req)
print(response.read().decode('utf-8'))
```


### 添加代理

```python
import urllib.request

proxy_handler = urllib.request.ProxyHandler({
    'http': 'http://127.0.0.1:9743',
    'https': 'https://127.0.0.1:9743'
})
opener = urllib.request.build_opener(proxy_handler)
response = opener.open('http://httpbin.org/get')
print(response.read())
```


### 添加cookies
cookie中保存中我们常见的登录信息，有时候爬取网站需要携带cookie信息访问,这里用到了http.cookijar，用于获取cookie以及存储cookie

```python
import http.cookiejar, urllib.request
cookie = http.cookiejar.CookieJar()
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open('http://www.baidu.com')
for item in cookie:
    print(item.name+"="+item.value)
```


#### 将cookie写入文件
1. http.cookiejar.MozillaCookieJar()方式

```python
import http.cookiejar, urllib.request
filename = "cookie.txt"
cookie = http.cookiejar.MozillaCookieJar(filename)
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open('http://www.baidu.com')
cookie.save(ignore_discard=True, ignore_expires=True)
```


2. http.cookiejar.LWPCookieJar()方式

```python
import http.cookiejar, urllib.request
filename = 'cookie.txt'
cookie = http.cookiejar.LWPCookieJar(filename)
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open('http://www.baidu.com')
cookie.save(ignore_discard=True, ignore_expires=True)
```


#### 加载文件中的cookie
同样的如果想要通过获取文件中的cookie获取的话可以通过load方式，当然用哪种方式写入的，就用哪种方式读取。

```python
import http.cookiejar, urllib.request
cookie = http.cookiejar.LWPCookieJar()
cookie.load('cookie.txt', ignore_discard=True, ignore_expires=True)
handler = urllib.request.HTTPCookieProcessor(cookie)
opener = urllib.request.build_opener(handler)
response = opener.open('http://www.baidu.com')
print(response.read().decode('utf-8'))
```


## 响应
响应类型、状态码、响应头

```python
import urllib.request
response = urllib.request.urlopen('https://www.python.org')
print(type(response))
```


我们可以通过response.status、response.getheaders().response.getheader("server")，获取状态码以及头部信息
response.read()获得的是响应体的内容


## URL解析
### urlparse
将urlstr解析成各个组件

```python
# -*- coding:utf-8 -*-
import urllib.request
import urllib.parse
url = "http://www.baidu.com"
parsed = urllib.parse.urlparse(url)
print(parsed)
#输出：ParseResult(scheme='http', netloc='www.baidu.com', path='', params='', query='', fragment='')
```


### urlunpars
其实功能和urlparse的功能相反，它是用于拼接，例子如下：

```python
from urllib.parse import urlunparse
data = ['http','www.baidu.com','index.html','user','a=123','commit']
print(urlunparse(data))
```


### urlencode
这个方法可以将字典转换为url参数

```python
from urllib.parse import urlencode

params = {
    "name":"zhaofan",
    "age":23,
}
base_url = "http://www.baidu.com?"

url = base_url+urlencode(params)
print(url)
```


## url编码

```python
from urllib import parse
from urllib import request

url = 'http://www.baidu.com/s?'
dict1 ={'wd': '百度翻译'}
url_data = parse.urlencode(dict1) #unlencode()将字典{k1:v1,k2:v2}转化为k1=v1&k2=v2
print(url_data)             #url_data：wd=%E7%99%BE%E5%BA%A6%E7%BF%BB%E8%AF%91
data = request.urlopen((url+url_data)).read() #读取url响应结果
data = data.decode('utf-8') #将响应结果用utf8编码
print(data)
url_org = parse.unquote(url_data) #解码url
print(url_org)              #url_org：wd=百度翻译
str1 = 'haha哈哈'
str2 = parse.quote(str1)    #将字符串进行编码
print(str2)                 #str2=haha%E5%93%88%E5%93%88
str3 = parse.unquote(str2)  #解码字符串
print(str3)                 #str3=haha哈哈
```


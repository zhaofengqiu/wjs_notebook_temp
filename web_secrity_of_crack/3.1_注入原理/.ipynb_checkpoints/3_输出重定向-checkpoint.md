>如果web页面做了默认页面的配置，或者做了限制对sql查询出来的结果。那解决方法很简单，只要不要将结果输出到web页面即可，我们可以将结果重定向到其他源。

## 通过e-mail重定向

### sql server
Database Mail服务（sql server 2005 以后的系列）
sp_send_dbmail语法：
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/smdd0tzn9yj.png" width="600px" />
例子：
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/27kkibnj51o.png" width="600px" />

### oracel
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/kgj9ndwwr3.png" width="600px" />

## 通过HTTP/DNS协议进行重定向
### Oracle
1. http协议
    + 要想向远程系统发送SYS用户的哈希口令,可注入下列字符串:
    <img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/2dhgbab3j4i.png" width="600px" />
    + 借助HTTPURL_TYPE对象
    <img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/0n5w3r5w4vjq.png" width="600px" />

2. DNS协议
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/6gu41zu00d4.png" width="600px" />



## 使用web应用进行重定向
如果攻击者拥有足够的写文件系统的权限,那么他就可以，将查询结果重定向到Web服务器根目录下的一个文件中,之后他便可以使用浏览器来正常访问该文件。而这个文件中已经一次性包含了很多sql查询的结果。
### sql server
1. 纯粹手工重定向
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/wi9cbs8n7f.png" width="600px" />
结果：
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/y7wx560rnjj.png" width="600px" />
2. 使用工具  
当提取少量信息时,该技术可以工作得很好,但如果提取整张表呢?对于这种情况,最好选用 bcp.exe。它是 SQL Server默认附带的一个命令行工具。MSDN对该工具的描述是:“bcp工具按照用户指定的格式在 Microsoft SQL Server实例和数据文件之间成块地复制数据”(请参阅htp:/msdnmicrosoft.com/enus/libarary/ms162802aspx)。bcp.exe是个功能很强大的工具.
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/i3f66bsrxlm.png" width="600px" />


### MySQL
1. 确保用户具有FILE权限
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/gin5cq5xpua.png" width="600px" />
2. 使用OUTFILE重定向
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/4ta4aaepbi5.png" width="600px" />

## 在移动设备上实施SQL注入

```{.python .input}

```

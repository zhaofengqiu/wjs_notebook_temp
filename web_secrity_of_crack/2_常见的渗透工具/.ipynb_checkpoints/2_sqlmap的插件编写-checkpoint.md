>SQLMap在默认情况下除了使用CHAR（）函数防止出现单引号，没有对注入的数 据进行修改，读者还可以使用--tamper参数对数据做修改来绕过WAF等设备，其中大 部分脚本主要用正则模块替换攻击载荷字符编码的方式尝试绕过WAF的检测规则.其中自带的tamper插件有53个脚本。

## 手工编写tamper插件
### tamper插件格式
打开一个插件，可以看到文件代码如下：

```python
from lib.core.enums import PRIORITY
__priority__ = PRIORITY.NORMAL
def dependencies():
    pass
def tamper(payload, **kwargs):
    return payload.replace("'", "\\'").replace('"', '\\"')
   
```


1. priority定义脚本的优先级，用于有多个tamper脚本的情况
2. dependencies函数声明该脚本适用／不适用的范围，可以为空。
3. tamper就是我们的插件，其中payload就是我们的注入网址，kwargs就是后面的参数，以字典的形式传入，如：

```
sqlmap http://xxx/ --tamper mytamper 
```


其中payload就是http://xxx/
tamper例子，将payload替换成base64编码后的payload。

```python
import base64
from lib.core.enums import PRIORITY
from lib.core.settings import UNICODE_ENCODING
__priority__ = PRIORITY.LOW
def dependencies():
    pass
def tamper(payload, **kwargs):
    return base64.b64encode(payload.encode(UNICODE_ENCODING)) if payload else payload
```


## 常见tamper插件
1. apostrophemask.py，将引号替换为UTF- 8，用于过滤单引号
<img src="../pictures/aikzpotpvqn.png" width="600" />



2. base64encode.py 作用： 替换为base64编码。
<img src="../pictures/whhtqapm84r.png" width="600" />
3. multiplespaces.py 作用：围绕SQL关键宇添加多个空格。ia4vjakfrs
<img src="../pictures/ia4vjakfrs.png" width="600" />

4. space2plus.py 作用：用＋号替换空格。
<img src="../pictures/hbfpniz6b8.png" width="600" />

5. nonrecursivereplacement.py 作用：作为双重查询语句，用双重语句替代预定义的SQL关键宇（适用于非常弱 的自定义过滤器，例如将SELECT替换为空〉。
<img src="../pictures/1gp52p66zsi.png" width="600" />


6. space2randomblank.py 作用：将空格替换为其他有效字符。
<img src="../pictures/tic0nrpsn0j.png" width="600" />
7. unionalltounion.py 作用：将UNION ALL SELECT替换为UNION SELECT 。

<img src="../pictures/k2cf3d23nk.png" width="600" />

8. securesphere.py 作用：追加特制的字符串 。
<img src="../pictures/r6dx2qu7ce8.png" width="600" />
9. space2hash.py 作用 ： 将空格替换为＃号，并添加一个随机字符串和换行符。
<img src="../pictures/6rf6d5t7rej.png" width="600" />




```{.python .input}

```

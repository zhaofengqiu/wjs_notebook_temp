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
S3可以和Lambda一起使用，即S3发生了改变，可以使用对应的事件。三种S3的存储使用情况：  
<img src="../pictures/2k64t2tc3zn.png" width="300" />



#### demo——使用GLUE和Athena创建数据湖
1. 创建存储桶
<img src="../pictures/ppceg74yx5.png" width="600" />



2. 上传文件
![image.png](../pictures/ibp32f17h3.png)

3. 创建一个IAM的Role
让role具备S3的访问权限以及GLUE的权限。即通过规则将S3和GLUE的权限联系起来。
<img src="../pictures/i82ko1tcix.png" width="600" />


4. 使用glue服务
创建数据库
<img src="../pictures/bwgf7vjsppw.png" width="300" />
使用爬虫来向GLUE中添加table
<img src="../pictures/ksdhgiko12e.png" width="600" />
<img src="../pictures/d8npxbhqoe8.png" width="600" />
<img src="../pictures/1w9utbucn0n.png" width="600" />



## EC2
>EC2类似一个小的linux系统的docker实例，其中的镜像是从AMI种获取。

这个是云计算计算服务（有CPU和GPU计算资源），是一个虚拟机服务



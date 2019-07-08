## 概述  
1. 数据胡拓展传统分析方法
<img src="../pictures/wits3q66cam.png" width="600" />


2. 数据胡拓展传统分析方法
<img src="../pictures/t2t4u6cxv5c.png" width="600" />


3. 数据湖处理流程
<img src="../pictures/9ogvwq94w87.png" width="600" />
    1. 将不同数据源,存储到S3存储桶。
    2. 由于来自于不同的数据源，导致数据的特性不一样，所以我们需要使用glue。当数据存储到对象存储中，会自动从对象存储中爬取数据。这个爬取的前提就是出发事件。
    3. glue对数据进行分析变成表，放入GLUE DATA CATALOG。对数据结构进行分析。数据还是存储在S3存储桶中

3. AWS GLUE服务
<img src="../pictures/afbx6dfpqgd.png" width="600" />


## EMR
>在云中托管的 Hadoop集群

EMR优点：
<img src="../pictures/hfybtqmqp3f.png" width="400" />
与其他AWS一起使用
<img src="../pictures/rpyw94uvx8.png" width="600" />
EMR是大数据处理的核心

## S3可信数据源，支持多个集群。

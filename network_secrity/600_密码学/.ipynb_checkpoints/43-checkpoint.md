## 密码通信模型
<img src="../pictures/d61ne4r06mo.png" width="600" />

## 概念阐述
<img src="../pictures/pmf0auetrs.png" width="600" />

## 密码系统的分类
<img src="../pictures/vhst40bp8i.png" width="600" />
<img src="../pictures/69ynwmdio23.png" width="600" />

## 密码分析的分类
<img src="../pictures/9i7g7nj6oa7.png" width="600" />

## 常见密码
### 古典密码技术
#### 替换密码技术

        以符号的置换来实现掩盖明文信息
        单字符单表密码，如凯撒密码。
                凯撒密码阐述，把明文中的所有字母都用它右边的第k个字母代替，F（a） = (a+k) mod n
                 (a表示明文字母，n表示集中字母个数，k表示密钥)
        单字符多表替换密码，如维吉尼亚密码，
                使用一个词组作为密钥。

#### 换位密码技术

1. 列换位密码
<img src="../pictures/ani02kj4xjn.png" width="600" />

2. 矩阵换位密码，即双重置换密码
<img src="../pictures/slptfgks4b.png" width="600" />

### 对称密码技术
>根据收发双方的密钥是否相同，加密方式可分为（对称加密，非对称加密），密钥在加密方和解密方之间传递和分发必须经过安全通道

1. 流密码算法：
                在加密过程中将密钥流（密钥的二进制位）与等长的二进制位进行模2运算，在解密过程中，是将密钥流与密文进行逐位模2运算，如A5-1流加密算法
<img src="../pictures/qrwp9umzkbi.png" width="600" />

2. 分组密码
典型的分组算法有，DES、3DES和AES。扩散和混淆是分组密码最本质的操作

<img src="../pictures/l757lftid88.png" width="600" />
feistel结构:
<img src="../pictures/aqbekfjk8am.png" width="600" />

每轮的子密钥也是不同的，难道密钥数 = 每轮的子密钥数*轮数？？？。
feistel结构要点：分组，密钥，轮函数

3. DES、3DES和AES的区别
![image.png](../pictures/ehfy7nwnau.png)
#### DES

i. 使用16轮操作的feistel结构密码
ii. 分组长度为64位
iii. 使用56位的密钥
iv. 每一轮使用48位的子密钥，每一个子密钥都是由56位的密钥的子集构成
<img src="../pictures/phila7ma5mi.png" width="600" />
#### 3DES算法
在DES的基础上进行三重和双密钥加密的算法
![image.png](../pictures/ehd2lc9ugcg.png)
如果k1=k2的话就是DES算法，可以和DES算法很好的兼容

####  AES算法
以8位字节为单位，明文分组长度为16字节（128bite）
<img src="../pictures/92avowlzl19.png" width="600" />
 实现过程：
 <img src="../pictures/ctxnj9lab8a.png" width="600" />



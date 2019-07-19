目标靶机IP:172.18.0.2 
kali攻击方IP:172.18.0.1
## 后 渗 透 攻 击 : 信 息收集

### 利用漏洞,开启shell

1. 获取漏洞,根据前面的收集信息获取到目标信息,目标存在samba漏洞
2. 设置参数
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/wm7s01e10fi.png" width="600px" />

3. 运行获取shell
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/f5f8txqaxv.png" width="600px" />

## 利用漏洞,开启meterpreter
1. 设置木马
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/297xxu3448x.png" width="600px" />

2. 修改木马权限,使其成为可执行程序

```shell
chmod +x wujiashuai
```


3. 运行木马程序

```shell
./wujiashuai
```


4. 开启meterpreter
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/r0nh84a0n3.png" width="600px" />
5. 使用meterpreter命令
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/dqc71i0cipp.png" width="600px" />

## 进程迁移
>在刚获得Meterpreter Shell 时 , 该 Shell 是极其脆弱和易受攻击 的,例 如攻击者可以 利 用浏览器漏洞攻陷目标机器 , 但攻击渗透后浏览器有可能被 用 户关闭。所 以 第一 步就是要移动这个 Shell , 把它和目标机中 一 个 稳定 的 进程绑定 在 一起 ,而不需 要对磁盘进行任何 写入操作 。 这样做使得渗透更难被检测到 。

```shell
migrate pid
```

## 收集信息

1. sysinfo 查看系统信息
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/f3ys374wyha.png" width="600px" />

2. route 查看路由信息
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/tfzwawywheb.png" width="600px" />

3. background 从meterpreter回到msf  
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/53d0akwf0qf.png" width="600px" />

4. route add  添加路由信息
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/qtw6eaigouj.png" width="600px" />

5. screengrab 截图
加载 load espia插件,然后screengrab截图
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/3kxgj9nvgj4.png" width="600px" />
6. 摄像机
    + 查看目标主机有没有摄像机 webcam_list
    + 打开摄像头拍摄图片 webcam_snap
    + 开启直播模式 webcam_stream
7. 进入目标主机shell
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/y39zsg9bg1.png" width="600px" />

linux 特有

windows特有

1. run post/windows/gather/enum_logged_on_users 命令列举当前有多 少 用户登录了目标机
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/s1bgz7gk86.png" width="600px" />

2. run post/windows/gather/enum_applications  列举安装在目标机上的应用程序
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/xbc14sdez9e.png" width="600px" /> 



3.  run windows/gather/credentials/windows_autologin 抓取自动登录 的用户名和密码
<img src="http://wujiashuaitupiancunchu.oss-cn-shanghai.aliyuncs.com/jupyter_notebook_img/8e23w5hrhe8.png" width="600px" />

4. 

```{.python .input}

```

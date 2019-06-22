# 配置防火墙接口
配置vlan接口

```
配置vlan
ASA(config)# interface  vlan  vlan_number
ASA(config-if)# nameif   outsider/insider/if_name  # 统一命名，方便管理。比如后面的acl部署
ASA(config-if)# security-level   vlaue
ASA(config-if)# ip address ip_addr mask_num
分配vlan
ASA(config)# interface Ethernet0/0  
ASA(config)# switchport access vlan vlan_number
```


配置vlan接口并且将vlan分配给实际物理接口。在这个过程中需要注意的是物理接口需要no shutdown。
## 验证vlan配置
ASA(config)# show switch vlan
## 验证ip地址
ASA(config)# show ip address 
## 验证接口配置
ASA(config)# show interface ip brief

# 配置ASA 5505防火墙默认路由
ASA(config)# route outside 0.0.0.0 0.0.0.0 209.165.200.225
ASA(config)# show  route
# 配置防火墙ACL
## 配置ACL
ASA(config)#access-list list-num  [extened]  [permit | deny] protocal  [source_addr ] [source port operator] [source_port] [destination_addr ] [destination port operator] [destination_port] [log]
 ## 部署方式
ASA(config)# access-group list-num in /out interface if-name
## 验证和查看
ASA# show access-list list-num 
ASA# show access-lists
# 定义NAT
指定公网地址范围：定义地址池 nat_id

```

ASA(config)# global  (outside)  nat_id   { interface |  ip_add1-ip_add2} 
```


动态地址分配

```
ASA(config)#nat (inside)  nat_id   net_addr  global_mask 
```


静态地址分配

```
ASA(config)# static (internal_if_name, external_if_name) protocol {interface|out_ip} [out_port] inside_ip [in_port ]  [netmark global_mask]

```
如：
static (inside,outside) 1.1.1.1 192.168.0.100 netmask 255.255.255.255 ////将外网IP地址1.1.1.1 做静态映射到 内网IP地址 192.168.0.100

NAT例子：

```
ASA(config)# interface Ethernet0/1
ASA(config-if)# nameif inside
ASA(config-if)# security-level 100
ASA(config-if)# ip address 192.168.1.1 255.255.255.0
ASA(config-if)# no shutdown
ASA(config-if)# exit
ASA(config)# nat (inside) 1 192.168.1.0 255.255.255.0
或  ASA(config)# nat (inside) 1 0.0.0.0 0.0.0.0   //建立一个内网需要映射的地址组，这里用的是0.0.0.0/0全网都可以映射，实际可以按照需要指定哪些地址为这个需要做NAT的地址组
ASA(config)# global (outside) 1 interface  //global表示全局默认NAT地址池，2为编号
```


```{.python .input}

```

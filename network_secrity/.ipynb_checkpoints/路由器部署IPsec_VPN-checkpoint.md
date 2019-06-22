# 创建IKE策略（主模式第一阶段）
```
Router(config)# crypto isakmp enable  
Router(config)# crypto isakmp policy priority  
Router(config--isakmp)#authentication pre-share|rsa-encr|rsa-sig   
Router(config--isakmp)#encryption des|3des|aes|aes192|aes256　
Router(config--isakmp)#group 1|2|5
Router(config--isakmp)#hash sha|md5   
Router(config--isakmp)#lifetime lifetime    
Router(config)# crypto isakmp key 0 keystring address peer-address   //为“pre-share” 认证方式配置密钥 

```
IKE策略中需要配置的策略有消息加密算法、消息完整性算法、对端认证算法、DH交换秘钥算法、SA生存时间
# 配置IPsec策略
```
R1(config)# crypto isakmp key cisco123 address 172.30.2.2
R1(config)# crypto ipsec transform-set MYSET esp-aes 128
R1(cfg-crypto-trans)# exit
```  
# 应用加密映射 (crypto map)
```
R1(config)# crypto map MYMAP 10 ipsec-isakmp
R1(config-crypto-map)# match address 110
R1(config-crypto-map)# set peer 172.30.2.2 default
R1(config-crypto-map)# set peer 172.30.3.2
R1(config-crypto-map)# set pfs group1
R1(config-crypto-map)# set transform-set mine
R1(config-crypto-map)# set security-association lifetime seconds 86400
R1(config-crypto-map)#exit
```  
# 分配加密映射  
```
R1(config)# interface serial0/0/0
R1(config-if)# crypto map MYMAP
```

```{.python .input}

```

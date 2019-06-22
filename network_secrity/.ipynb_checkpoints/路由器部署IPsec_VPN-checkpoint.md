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

# Docker 常用操作
## docker
	• systemctl start docker 
	• systemctl stop docker
## 镜像的搜索  
	docker search xx
	如：docker search python 搜索与python相关的镜像
## 下载镜像  
	docker pull ios_gname
## 查看本地存在的镜像  
	docker images
	镜像存在一个唯一的id，即tag标签，表示唯一的版本号。
## 查看当前存在那些容器 
	docker ps -a
  ![image.png](/docker/pictures/u3lsia6lk.png)
## 创建容器 
	docker run -tid IMAGE_ID 
		-ti 表示用交互的形式来创建容器
		-d 表示以后台的形式来创建
		-tid表示创建一个容器并去运行他，常用的经典组合
## 启动容器 
	docker start CONTAINER_ID/CONTAINER_NAME 
## 进入容器 
	docker attach CONTAINER_ID
## 退出容器  
	exit	退出容器的时候，也会停止容器
	Ctrl+P+Q	退出容器的时候，不会停止容器
	
## 给容器起名字                                                                                                                                       
	docker run -tid --name CONTAINER_NAME CONTAINER_ID
## 容器封装成镜像
docker commit   CONTAINER_ID IOS_NAME:version

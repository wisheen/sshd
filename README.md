# 简介

基于docker容器运行的sshd服务，在不干扰当前宿主机的情况下，主要有如下用途：

* 提供网络端口代理

* 可作为jenkins的工作节点

* 可作为debian操作系统的学习环境

* 可作为vscode的linux开发环境

# 构建

~~~ code bash
sudo docker build -t sshd ./
~~~

# 运行

~~~ code bash
# 启动一个sshd服务，当前用户的公钥传递给AUTHORIZED_KEY环境变量，监听端口为222
sudo docker run -d --rm -p 222:22 -e AUTHORIZED_KEY="$(cat $HOME/.ssh/id_rsa.pub)" sshd

# 连接到启动的sshd服务，由于当前用户有/home/user/.ssh/id_rsa私钥，将可免密登陆到容器环境
ssh -p 222 root@127.0.0.1

# 提示：启动容器将默认基于ed25519算法生成密钥，可把提示的类似如下的内容复制到执行ssh客户端的机器，放在$HOME/.ssh/id_ed25519，并修改权限为600，上面AUTHORIZED_KEY不指定也可免密登陆
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACAD3ASyiIe9cJzjOWWQOYsZtpd+TgtfnVfa7k7reCdlLwAAAJgcWhhUHFoY
VAAAAAtzc2gtZWQyNTUxOQAAACAD3ASyiIe9cJzjOWWQOYsZtpd+TgtfnVfa7k7reCdlLw
AAAEB8j339gKqKhPL3D9sHrqDCzqRFhrMVPpBygYM1GS/39gPcBLKIh71wnOM5ZZA5ixm2
l35OC1+dV9ruTut4J2UvAAAAEXJvb3RAODg3Y2RmYjA1MGMyAQIDBA==
-----END OPENSSH PRIVATE KEY-----
~~~

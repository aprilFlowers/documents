# VAGRANT
## 安装步骤
	vagrant add testname path 装镜像(path是下载的box在linux中的路径)
	vagrant init name 安装box
## 配置vagrant文件。。配置Vagrantfile：
	config.vm.network "程序包所在路径", "更换的开发路径"（原始的开发路径为/vagrant）
## 开启
	vagrant up 开启虚拟机
	vagrant provision 跑虚拟机配置脚本，开启服务器
	vagrant ssh 登录虚拟机

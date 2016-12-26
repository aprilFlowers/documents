# 进程管理（计时器）
corntabs 和 cornjobs  计时器设置,执行周期性的指定命令，每一个进程（cron）在指定时间醒来，去检查crontab文件是否有任务需要执行。
## 安装corntabs
	yum install -y vixie-cron
	service crond status 显示计时器服务状态
	service crond start 开启进程服务  用户权限可能不够，添加sudo 使用root身份执行
## 编辑
	crontab -l   列表显示所有cron命令
	crontab -e  创建
	进入编辑页面，填写cron命令，每一行是一条命令。caps lock+i insert状态 esc 退出 shift+:  操作   q退出  qw 保存退出
## corntabs命令格式
	20　4　＊　＊　＊　program
	分   时   天     月   周     运行命令
## laravel支持corn
### laravel 任务调度计时器cron格式
	* * * * * php /path/to/artisan schedule:run >> /dev/null 2>&1
	                       artisan存在路径        指定日志存在路径，自动创建，/dev/null 指的是当前设备的垃圾桶
## 开启
	service crond restart 重启   
	需要重写cron命令时也是使用 crontab -e,查看日志使用vim (当查看文件不存在时，会创建空文件内容
	tail -f 文件名   实时显示文件内容
	crontab -r 删除
	chkconfig --list 查看服务目录
## laravel支持corn
### laravel 任务调度计时器cron格式
	* * * * * php /path/to/artisan schedule:run >> /dev/null 
	                     artisan存在路径        指定日志存在路径，自动创建，/dev/null 指的是当前设备的垃圾桶


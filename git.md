# GIT常用命令
## 提交代码
	git add -A
	git status
	git commit -m 'msg'
	git push origin branch
## 拉取代码
	git clone link 
	git pull origin branch 更新代码
## 修复故障
	git reset --hard 回退本地修改到指定提交状态
	git reset HEAD^ 本地回滚未提交状态
	git checkout branch 切换分支
	git branch 查看当前所属分支 -a 显示所有分支

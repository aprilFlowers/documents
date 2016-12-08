# GIT常用命令
## 基本设置
	git config --global user.name 'wufl'
	git config --global user.email 'wufl_april@162.com'
## 提交代码
	git init 创建git仓库
	git clone /path
	touch test.txt
	vim test.txt
	git add -A
	git status
	git commit -m 'msg'
	git remote add origin 
	git push origin branch
	git merge branch 合并其他分支带当前分支
	git giff source_branch target_branch
## 拉取代码
	git clone link 
	git pull origin branch 更新代码
## 修复故障
	git fetch origin 获取远程文件
	git reset --hard origin/master 回退本地修改到指定提交状态,两者一起可以丢弃本地修改与提交
	git checkout -- fileName 使用HEAD中最新内容替换当前文件，做错事的本地文件
	git reset HEAD^ 本地回滚未提交状态
	git checkout branch 切换分支
	git checkout -b branch 创建新分支并切换过去
	git checkout -d branch 删除分支
	git branch 查看当前所属分支 -a 显示所有分支
	git log
## 使用ssh验证
	ls -a; ~/.ssh 查看ssh是否存在
	ssh-agent bash
	ssh-keygen -t rsa -C 'wufl_april@126.com'
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa 生成的ssh key 添加到ssh-agent 
	添加密钥到github  (id_rsa.pub)
	git remote -v 查看当前remote方式
	git remote set-url origin git@github.com:aprilFlowers/jiangren.git


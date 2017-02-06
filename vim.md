# VIM常用快捷键
## 小键盘
	hjkl  左下上右
## 编辑模式
	gg 到第一行
	G 到最后一行
	nG 到某一行
	0 行首
	$ 行尾
	o 在当前行上面新建一行 
	O 在当前行下面新建一行
	dd 删除/剪切当前行
	ndd 剪切n行
	dG 光标所在到文件末尾
	G 光标所在到当前行
	u 撤销上一步操作
	r 替换当前字符
	R 进入替换状态
	x 删除当前字符
	yy/Y 复制当前行
	nyy 复制当前光标下的n行
	P 粘贴到光标前
	p 粘贴到光标后
	ctrl+v 块选择(d: 删除选定的块，c:删除块之后进入插入模式)
	:map  I#<ESC> 定义快捷键
## 命令行模式
	:set nu 显示行号
	:set nonu 不显示行号
	:s/old/new 用new替换首次找到的old
	:s/old/new/g 文档中old全部替换
	:n1,n2s/old/new/g n1,n2范围中old全部替换
	:%s/old/new/g 替换文件中当前的所有old
	:r 导入
## 使用小贴士
	:1,$d 删除全部文本
	shift+v 选中当前行文本

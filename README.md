###服务器免登陆脚本

- 使用方法：

		chmod +x ./sshnopwd.sh

		./sshnopwd.sh -h hostname -u username  -a alias

- 参数说明：

	-h : 服务器名称
	
	-u : 用户名
	
	-a : 别名，用于terminal中ssh的服务器简写 
	
- 实例：

	例如服务器名称为 xx.a.net  用户名为 admin  想使用的别名为 xx
	
	则: ./sshnopwd.sh -h xx.a.net -u admin  -a xx
	
	执行一次之后，以后要登录服务器只需要  ssh xx  就可以了，无需输入密码
	
	

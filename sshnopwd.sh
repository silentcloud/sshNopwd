#! /bin/sh

#检查本地是否有~/.ssh目录
if [ ! -f $HOME/.ssh/id_rsa.pub ];then
    ssh-keygen -t rsa -N "" -C "" -f $HOME/.ssh/id_rsa
fi

usage() 
{
    echo "usage: `basename $0` -h host -u username -a alias"
    exit 1
}

#判断参数个数是否为6
if [ $# != 6 ];then  
    usage
fi

#判断参数并赋值
while getopts h:u:a: OPTION  
do    
    case $OPTION in 
        h) host=$2
        ;;
        u) username=$4
        ;;
        a) alias=$6
        ;;
        \?) usage
        ;;    
    esac
done

cat $HOME/.ssh/id_rsa.pub | ssh ${username}@${host} "
    mkdir -p /home/admin/.ssh
    cat - >> /home/admin/.ssh/authorized_keys
"

if [ $? -ne 0 ];then
    echo "please check The host & username ,ssh failed !"
    exit 1
fi

#判断别名是否已经存在

cat $HOME/.ssh/config | grep "$alias"

if [ $? -eq 0 ];then
    echo "ssh alias exists,please use another!"
    exit 1
fi

cat>>$HOME/.ssh/config<<EOF  
Host $alias
    HostName $host
    Port 22
    User $username

EOF

#输出成功信息，和登录服务器方式
echo "Authorized info uploads success!"
echo "please use 'ssh $alias' command to login in server!"

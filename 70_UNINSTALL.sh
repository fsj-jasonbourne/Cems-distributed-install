#!/bin/bash
#***************************************************
# 流程：
# 对所有uninstall.sh脚本统一dos2unix一次
# 分别到各自服务目录下执行uninstall脚本,以vrv用户
# 卸载完成后统一杀一次java进程
# 卸载完成后直接删除/usr/local/service/目录
# 卸载完成后删除/etc/init.d/下CEMS开头的所有服务
#***************************************************
SEVEN_ZERO_SERVICE=(CEMS-SERVICE-MONITOR
                    CEMS-SERVICE-ALARM
                    CEMS-SERVICE-DATAPROCESS
                    CEMS-SERVICE-PTP
                    CEMS-SERVICE-SUPGRADE)

SEVEN_ZERO_TOMCAT=(CEMS-C-TCP
                   CEMSUP)

package_name="dos2unix-3.1-37.el6.x86_64.rpm"
service_path="/usr/local/service/"
auto_start_path="/etc/init.d/"

function JudgeSoftware()
{
    rpm -qa|grep dos2unix
    judge_dos=$?
    if [[ ${judge_dos} -eq 1 ]]
    then
    {
        echo "【dos2unix安装包正在安装】"
        rpm -ivh  ./package/${package_name}
    }
    else
    {
        echo "【dos2unix安装包已安装】"
    }
    fi
}

function DosToUnix()
{
    for install_file in ${SEVEN_ZERO_SERVICE[@]}
    do
    {
        cd /usr/local/service/${install_file}/bin/
        dos2unix  uninstall.sh 
    }	
    done
}

function ExeUninstall()
{
    for install_file in ${SEVEN_ZERO_SERVICE[@]}
    do
    {
        cd /usr/local/service/${install_file}/bin/
        su vrv  ./uninstall.sh
        echo "【服务包${install_file}正在卸载】"
    }	
    done
}

function KillJava()
{
    pkill -9 java
}

function DeleteDirectory()
{
    rm -rf ${service_path}
}

function DeleteService()
{
    rm -rf ${auto_start_path}CEMS*
}

function RebootSystem()
{
   echo "【服务器将于1分钟后自动重启，是否执行Y/N】"
   read answer
   echo "您的输入选择是:${answer}"
   if [[ ${answer} == "Y" ]]
   then
   {
       echo "【服务器将于1分钟后自动重启】"
       sleep 60
       reboot
   }
   elif [[ ${answer} == "N" ]]
   then
   {
       echo "【服务器不进行重启操作】"    
   }
   else
   {
       echo "【您输入值存在错误】"
   }
   fi
}

function Main()
{
    JudgeSoftware
    DosToUnix
    ExeUninstall
    KillJava
    DeleteDirectory
    DeleteService
    RebootSystem
}

Main

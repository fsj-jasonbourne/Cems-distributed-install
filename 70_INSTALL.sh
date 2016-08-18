#!/bin/bash
# CEMS服务     --->7个
# CEMS-SERVICE --->5个
# CEMS-TOMCAT  --->2个
SEVEN_ZERO_SERVICE=(CEMS-SERVICE-MONITOR
		    CEMS-SERVICE-ALARM
		    CEMS-SERVICE-DATAPROCESS
		    CEMS-SERVICE-PTP
   		    CEMS-SERVICE-SUPGRADE)

SEVEN_ZERO_TOMCAT=(CEMS-C-TCP
		   CEMSUP)

CONFIG_FILE='config.properties'
FASTDFS_FILE='fastdfs.properties'
JDBC_FILE='jdbc.properties'
POLICY_FILE='policy.xml'
REDIS_FILE='redis.properties'
FTP_FILE='ftp.properties'

PATH_INSTALL='/usr/local/service/'
PATH_CONFIG='/usr/local/service/'

function InputAddress()
{
	echo "<--Please input server.IP-->:"	
	read SERVER_IP
	echo "<--Please input service.IP-->:"
	read SERVICE_IP
	echo "<--Please input fastdfs.IP-->"
	read FASTDFS_IP
	echo "<--Please input jdbc.IP-->"
	read JDBC_IP
	echo "<--Please input ftp.IP-->"
	read FTP_IP
	echo "<--Please input redis.IP-->"
	read REDIS_IP
	echo "<--Please input CEMS.IP-->"
	read CEMS_IP

}

function ConfigProperties()
{	
	# edit server.ip
	\sed -i "/server\.ip=/s/=.*/=${SERVER_IP}/g" ${CONFIG_FILE}	
	# edit service.ip
	\sed -i "/service\.ip=/s/=.*/=${SERVICE_IP}/g" ${CONFIG_FILE}	
}

function FastdfsProperties()
{
	
	#\sed -i "s/tracker_server=.*.:22122/tracker_server=${FASTDFS_IP}:22122/g" ${FASTDFS_FILE}
	# tracker_server = 192.168.134.68:22122	
	\sed -i "s/=.*.:22122/=${FASTDFS_IP}:22122/g" ${FASTDFS_FILE}
	# tracker_server=:22122
	\sed -i "s/=:22122/=${FASTDFS_IP}:22122/g" ${FASTDFS_FILE}
}

function JdbcProperties()
{
	
	sed -i "s/mysql:\/\/.*.:3306/mysql:\/\/${JDBC_IP}:3306/g" ${JDBC_FILE}
	# for mysql://:3306	
	sed -i "s/mysql:\/\/:3306/mysql:\/\/${JDBC_IP}:3306/g" ${JDBC_FILE}
}

function RedisProperties()
{
	\sed -i "/redis.host=.*/s/=.*/=${REDIS_IP}/g" ${REDIS_FILE}
}

function FtpProperties()
{
	\sed -i "/ftp.ip=.*/s/=.*/=${FTP_IP}/g" ${FTP_FILE}
}
function PolicyXml()
{
        \sed -i "s/loadbalance:\/\/.*.:3306/loadbalance:\/\/${SERVER_IP}:3306/g" ${POLICY_FILE}
	\sed -i "s/mysql:\/\/.*.:3306/mysql:\/\/${SERVER_IP}:3306/g" ${POLICY_FILE}
	# 11s---jdbc ip
	sed -i "11s/<ip>.*.<\/ip>/<ip>${JDBC_IP}<\/ip>/g" ${POLICY_FILE}
	# 23s---jdbc ip
	sed -i "23s/<ip>.*.<\/ip>/<ip>${JDBC_IP}<\/ip>/g" ${POLICY_FILE}
	# 32s---redis ip
	sed -i "32s/<ip>.*.<\/ip>/<ip>${REDIS_IP}<\/ip>/g" ${POLICY_FILE}
	# 38s---cache ip ---same to redis
	sed -i "38s/<ip>.*.<\/ip>/<ip>${REDIS_IP}<\/ip>/g" ${POLICY_FILE}
	# 43s---ftp ip 
	sed -i "43s/<ip>.*.<\/ip>/<ip>${FTP_IP}<\/ip>/g" ${POLICY_FILE}
	# 52s---tracker ip
	sed -i "s/<tracker_server>.*.:22122/<tracker_server>${REDIS_IP}:22122/g" ${POLICY_FILE}
	# 59s---CEMS ip 
	sed -i "59s/<ip>.*.<\/ip>/<ip>${CEMS_IP}<\/ip>/g" ${POLICY_FILE}
	# 65s---CEMSUP ip 
	sed -i "65s/<ip>.*.<\/ip>/<ip>${FTP_IP}<\/ip>/g" ${POLICY_FILE}
	# 70s---CONFIGURE ip---same to redis	
	sed -i "70s/<ip>.*.<\/ip>/<ip>${REDIS_IP}<\/ip>/g" ${POLICY_FILE}
}

function ConfigFiles()
{
	for service in ${SEVEN_ZERO_SERVICE[@]}
	do
	{
		echo ${service}
		# config.properties
		if [ -f ${PATH_CONFIG}${service}/config/${CONFIG_FILE} ]
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			ConfigProperties
		}
		fi
		# fastdfs.properties
		if [ -f ${PATH_CONFIG}${service}/config/${FASTDFS_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			FastdfsProperties		
		}
		fi
		# jdbc.properties
		if [ -f ${PATH_CONFIG}${service}/config/${JDBC_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			JdbcProperties		
		}
		fi
		# redis.properties
		if [ -f ${PATH_CONFIG}${service}/config/${REDIS_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			RedisProperties		
		}
		fi
		# ftp.properties
		if [ -f ${PATH_CONFIG}${service}/config/${FTP_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			FtpProperties		
		}
		fi
		# policy.xml
		if [ -f ${PATH_CONFIG}${service}/config/${POLICY_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			PolicyXml		
		}
		fi

	}
	done 

	for service in ${SEVEN_ZERO_TOMCAT[@]}
	do
	{
		echo ${service}
		# config.properties
		if [ -f ${PATH_CONFIG}${service}/config/${CONFIG_FILE} ]
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			ConfigProperties
		}
		fi
		# fastdfs.properties
		if [ -f ${PATH_CONFIG}${service}/config/${FASTDFS_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			FastdfsProperties		
		}
		fi
		# jdbc.properties
		if [ -f ${PATH_CONFIG}${service}/config/${JDBC_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			JdbcProperties		
		}
		fi
		# redis.properties
		if [ -f ${PATH_CONFIG}${service}/config/${REDIS_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			RedisProperties		
		}
		fi
		# ftp.properties
		if [ -f ${PATH_CONFIG}${service}/config/${FTP_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			FtpProperties		
		}
		fi
		# policy.xml
		if [ -f ${PATH_CONFIG}${service}/config/${POLICY_FILE} ] 
		then
		{
			cd ${PATH_CONFIG}${service}/config/
			PolicyXml		
		}
		fi

	}
	done
}

function ConfigService()
{
	# judge /usr/local/service exist ???
	if [ -d ${PATH_INSTALL} ]
	then
	{
		echo "path exist!"
	}
	else
	{
		echo "path not exist!"
		mkdir /usr/local/service/
	}
	fi
	# copy CEMS-SERVERS to /usr/local/service
	echo "start to copy CEMS-SERVICES files......"
	for service in ${SEVEN_ZERO_SERVICE[@]}
	do
	{
		\cp  -rpf ${service} ${PATH_INSTALL}
	}
	done
	echo "start to copy CEMS-TOMCAT files......"
	for service in ${SEVEN_ZERO_TOMCAT[@]}
	do
	{
		\cp  -rpf ${service} ${PATH_INSTALL}
	}
	done

	echo "start to execute function ConfigFiles"
	ConfigFiles
}

function Main()
{
	InputAddress
	ConfigService
}

Main


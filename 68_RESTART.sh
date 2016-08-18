#!/bin/bash
# CEMS服务    ---> 8个
# TOMCAT服务  ---> 1个
# SERVICE服务 ---> 7个

SIX_EIGHT_SERVICE=(CEMS-SERVICE-MONITOR
   	           CEMS-SERVICE-TOAUTH
	           CEMS
		   CEMS-SERVICE-POLICY
		   CEMS-SERVICE-ONLINE
		   CEMS-SERVICE-BLOCK
		   CEMS-SERVICE-SUPGRADE
		   CEMS-SERVICE-UPDOWNLOAD)

function ServiceRestart()
{
   for SIX_EIGHT in ${SIX_EIGHT_SERVICE[@]}
   do
   {
       echo "*****************************************************${SIX_EIGHT}"
       service ${SIX_EIGHT} restart
       sleep 3
   }
   done
}

function Main()
{
   ServiceRestart
}

Main


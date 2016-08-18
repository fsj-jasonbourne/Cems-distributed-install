#!/bin/bash
# CEMS服务    ---> 8个
# TOMCAT服务  ---> 1个
# SERVICE服务 ---> 7个

SEVEN_ZERO_SERVICE=(CEMS-SERVICE-MONITOR
                    CEMS-SERVICE-ALARM
                    CEMS-SERVICE-DATAPROCESS
                    CEMS-SERVICE-PTP
                    CEMS-SERVICE-SUPGRADE
                    CEMS-C-TCP
                    CEMSUP)
function ServiceRestart()
{
   for SIX_EIGHT in ${SEVEN_ZERO_SERVICE[@]}
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


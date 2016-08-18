#!/bin/bash
# CEMS服务    ---> 8个
# TOMCAT服务  ---> 1个
# SERVICE服务 ---> 7个


SIX_NINE_SERVICE=(CEMS-SERVICE-MONITOR
                  CEMS-SERVICE-CONFIGURE
                  CEMS-SERVICE-ADDRESS
                  CEMS-SERVICE-CUPGRADE
                  CEMS-SERVICE-PATCH
                  CEMS-SERVICE-SCAN
                  CEMS-SERVICE-SUPGRADE
                  CEMS-SERVICE-CACHE
                  CEMS-C-UDP
                  CEMS-SERVICE-UDISK)

function ServiceRestart()
{
   for SIX_EIGHT in ${SIX_NINE_SERVICE[@]}
   do
   {
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


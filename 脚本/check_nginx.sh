#!/bin/bash
#检测nginx是否正常运行
if  /usr/sbin/pidof  nginx  ;then
	exit 0
else
	exit 1
fi

#!/usr/bin/env bash
# /**************************************************************************
#  *
#  * init modify  : 2019年08月17日(土)
#  * modify       : 2019年08月17日(土)
#  * summary      : qmail mta における, 滞留しているキューを削除するスクリプト
#  * commit       : 2019年08月17日(土) 初版作成 Ver.0.01
#  *
# **************************************************************************/
arrayQueueList=($(/var/qmail/bin/qmail-qread | awk '{ print $6 }' | sed 's/#//g' | sed '/^$/d'))
arrayQueueListSize=$(echo ${#arrayQueueList[@]})

systemctl status qmail

for((i = 0; i < $arrayQueueListSize; i++)); do
    echo "queue is "$i" : "${arrayQueueList[$(( i ))]}
    find /var/qmail/queue -name ${arrayQueueList[$(( i ))]} | xargs rm -fv

done

systemctl restart qmail
systemctl status qmail

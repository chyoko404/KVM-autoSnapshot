#!/bin/sh
current=`date "+%Y-%m-%d %H:%M:%S"`  
currentTimeStamp=`date -d "$current" +%s`   
echo $currentTimeStamp
for i in $(virsh list --name)
do
#create snapshop
        virsh snapshot-create $i
#delete overtime snapshot
        for k in $(virsh snapshot-list $i --name)
        do
                declare -i c=$currentTimeStamp-$k
                #echo $c
                if [ "$c" -gt "255600" ];then
                        virsh snapshot-delete $i --snapshotname $k
                        #echo $k
                fi
        done
done

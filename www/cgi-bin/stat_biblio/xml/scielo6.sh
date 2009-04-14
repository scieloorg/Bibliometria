#!/bin/bash

#echo Content-type: text/html
echo Content-type: text/plain
echo  

. ./SetVar.txt
export ARQ=$TMP/$PPID.scielo6
#export ARQ=../../../tempor/$PPID.scielo6


rm -rf $ARQ.*

echo "BTELL|0" >$ARQ.gizmo.seq
$UTL/mxget "@$HOM/scielo6cgi.pft" >>$ARQ.gizmo.seq
$UTL/mx null -all now "proc='a5555~$ARQ~a7777~$DOMAIN~'" count=1 create=$ARQ.arq
$UTL/mx seq=$ARQ.gizmo.seq -all now create=$ARQ.gizmo
$UTL/mx "seq=$HOM/scielo6mod.sh{" -all now gizmo=$ARQ.gizmo lw=0 pft=v1# >$ARQ.sh

chmod 777 $ARQ.*

sh  $ARQ.sh

rm -rf $ARQ.*

###rm /tmp/*elo6*

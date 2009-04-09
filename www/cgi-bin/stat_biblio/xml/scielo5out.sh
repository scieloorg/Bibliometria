#!/bin/bash

echo Content-type: text/plain
echo  

. ./SetVar.txt
#export ARQ=$TMP/$PPID.scielo5
export ARQ=../../../tempor/$PPID.scielo5



rm -rf $ARQ.*

echo "BTELL|0" >$ARQ.gizmo2.seq
$UTL/mxget "@$HOM/scielo5cgi2.pft" >>$ARQ.gizmo2.seq
$UTL/mx seq=$ARQ.gizmo2.seq -all now create=$ARQ.gizmo2
$UTL/mx "seq=$HOM/scielo5mod2.sh{" -all now gizmo=$ARQ.gizmo2 lw=0 pft=v1# >$ARQ.2.sh

chmod 777 $ARQ.*

sh  $ARQ.2.sh

rm -rf $ARQ.*
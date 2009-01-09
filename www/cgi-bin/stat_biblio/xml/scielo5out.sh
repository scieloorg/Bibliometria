#!/bin/bash

echo Content-type: text/plain
echo  

. ./SetVar.txt
export ARQ1=$TMP/$PPID.scielo5



rm -rf $ARQ1.*

echo "BTELL|0" >$ARQ1.gizmo2.seq
$UTL/mxget "@$HOM/scielo5cgi2.pft" >>$ARQ1.gizmo2.seq
$UTL/mx seq=$ARQ1.gizmo2.seq -all now create=$ARQ1.gizmo2
$UTL/mx "seq=$HOM/scielo5mod2.sh{" -all now gizmo=$ARQ1.gizmo2 lw=0 pft=v1# >$ARQ1.2.sh

chmod 777 $ARQ1.*

sh  $ARQ1.2.sh

rm -rf $ARQ1.*
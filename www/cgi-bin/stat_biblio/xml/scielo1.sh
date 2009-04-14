#!/bin/bash

#echo Content-type: text/html
echo Content-type: text/plain
echo  

. ./SetVar.txt
export ARQ=$TMP/$PPID.scielo1
#export ARQ=../../../tempor/$PPID.scielo1


rm -rf $ARQ.*

$UTL/mxget "@$HOM/scielo1cgi.pft" >$ARQ.gizmo.seq
$UTL/mx seq=$ARQ.gizmo.seq -all now create=$ARQ.gizmo
$UTL/mx null count=0 create=$ARQ.tits
$UTL/mx null count=0 create=$ARQ.anos
$UTL/mx $ARQ.gizmo -all now uctab=ansi append=$ARQ.tits "proc=if v1='t' then else 'd*' fi"
$UTL/mx $ARQ.gizmo -all now append=$ARQ.anos "proc=if v1='a' then 'Gsplit=2=;' else 'd*' fi"
$UTL/mx $ARQ.tits -all now create=$ARQ.titsanos lw=0 "pft=S1:=(v2),ref(['$ARQ.anos']1,(if p(v2) then S1,'^a'v2/ fi))" outmfntag=1 
$UTL/mx null -all now "proc='a5555~$ARQ~a7777~$DOMAIN~'" count=1 create=$ARQ.arq
$UTL/mx $ARQ.gizmo count=4 create=$ARQ.gizmo1 -all now
$UTL/mx "seq=$HOM/scielo1mod.sh{" "gizmo=$ARQ.gizmo1" -all now lw=0 pft=v1# >$ARQ.sh

chmod 777 $ARQ.*

sh  $ARQ.sh

rm -rf $ARQ.*

##rm /tmp/*scielo1*

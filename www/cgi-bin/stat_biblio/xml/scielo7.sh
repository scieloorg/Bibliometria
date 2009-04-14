#!/bin/bash

#echo Content-type: text/html
echo Content-type: text/plain
echo  

. ./SetVar.txt
export ARQ=$TMP/$PPID.scielo7
#export ARQ=../../../tempor/$PPID.scielo7

rm -rf $ARQ.*

$UTL/mxget "@$HOM/scielo7cgi.pft" >$ARQ.gizmo.seq
$UTL/mx seq=$ARQ.gizmo.seq -all now create=$ARQ.gizmo
$UTL/mx null count=0 create=$ARQ.tits
$UTL/mx null count=0 create=$ARQ.pais1
$UTL/mx null count=0 create=$ARQ.pais
$UTL/mx null count=0 create=$ARQ.anos
$UTL/mx $ARQ.gizmo -all now append=$ARQ.tits "proc=if v1='t' then else 'd*' fi"
$UTL/mx $ARQ.gizmo -all now append=$ARQ.pais1 "proc=if v1='c' then else 'd*' fi"
$UTL/mx $ARQ.gizmo -all now append=$ARQ.pais "proc=if v1='p' then else 'd*' fi"
$UTL/mx $ARQ.gizmo -all now append=$ARQ.anos "proc=if v1='a' then 'Gsplit=2=;' else 'd*' fi"
$UTL/mx $ARQ.pais -all now create=$ARQ.paisanos lw=0 "pft=S1:=(v2),ref(['$ARQ.anos']1,(if p(v2) then '^t'ref(['$ARQ.tits']1,v2),'^c'ref(['$ARQ.pais1']1,v2),'^p'S1,'^a'v2/ fi))" outmfntag=1 
$UTL/mx null "proc='a5555~$ARQ~a7777~$DOMAIN~'" count=1 create=$ARQ.arq -all now
$UTL/mx $ARQ.gizmo count=9 create=$ARQ.gizmo1 -all now
$UTL/mx "seq=$HOM/scielo7mod.sh{" "gizmo=$ARQ.gizmo1" -all now lw=0 pft=v1# >$ARQ.sh

chmod 777 $ARQ.*

sh  $ARQ.sh

rm -rf $ARQ.*

#rm /tmp/*elo7*

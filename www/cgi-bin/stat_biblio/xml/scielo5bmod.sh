# **** Citacoes Concedidas - resultados separados ****

BEGIN

$UTL/mxtbansi BASE create=$ARQ.mxtbc uctab=ansi btell=BTELL "bool=BOOLC" "200:if v1^c>'' then '^n'v1^t'^s'ref(['tab30issn']l(['tab30issn']v1^t),mpu,v222^a,mpl),'^c',e1:=l(['tab30isi']v1^c),if e1>0 then ref(['tab30isi']e1,mpu,v2,mpl) else mpu,v1^c.60 fi,'^i',v1^i fi" tab=v999 class=100000 

 $UTL/msrt $ARQ.mxtbc 110 v1^s,v998
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalc "9:v1^n" tab=v999
 $UTL/mx $ARQ.totalc "fst=1 0 v1" fullinv=$ARQ.totalc
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalr "5:'Total de revistas'" tab=v999
 
 $UTL/mx null count=1 -all now create=$ARQ.title1 "proc='a11~SHOWrev~a22~SHOWanoP~a65~SHOWanoC~a5555~',ref(['$ARQ.arq']1,v5555),'~'"
$UTL/mx $ARQ.title1 lw=0 count=1 now ISSN FORMA1
 
  ###Total igual a zero
 $UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)='' then FORMA2a fi" lw=9999
 ###
 
 $UTL/mx $ARQ.mxtbc create=$ARQ.mxtbcST -all now lw=0 "proc='a1111~'ref(['$ARQ.totalc']l(['$ARQ.totalc']v1^n),v999)'~a2222~'ref(['$ARQ.totalr']1,v999)'~a5555~',ref(['$ARQ.arq']1,v5555),'~'" 
 $UTL/mx $ARQ.mxtbcST count=1 now lw=0 FORMA2 
 
 $UTL/mx $ARQ.mxtbcST create=$ARQ.mxtbcg -all now 

 $UTL/mx $ARQ.mxtbcST  now lw=0 "proc='a288~SC_ANO~a265~65_ANO~a333~LANG~a5000~FOR1~a7777~'ref(['$ARQ.arq']1,v7777)'~a7766~'ref(['$ARQ.arq']1,v7766)'~'" FORMA3 

 $UTL/mx null count=1 now lw=0 "pft=if ref(['$ARQ.mxtbc']1,v1)<>'' then '</table_list>' fi" 

END 

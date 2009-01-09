# **** Citacoes Recebidas - resultados separados ****

BEGIN

  $UTL/mxtbansi BASE create=$ARQ.mxtbc uctab=ansi btell=BTELL "bool=BOOLC" "200:e1:=l(['title']v1^c.60),if e1>0 or v1^c='' then '^n',v1^i,'^c',ref(['title']l(['title']v1^t.9),mpu,v100.60,mpl) fi" tab=v999 class=200000 
 $UTL/mx $ARQ.mxtbc create=$ARQ.copy uctab=ansi -all now "proc='d1a1~'v1'^s'ref(['tab30issn']l(['tab30issn']v1^n),mpu,v222^a,mpl)'~'"
 $UTL/mx $ARQ.copy create=$ARQ.mxtbc -all now
 $UTL/msrt $ARQ.mxtbc 110 v1^s,v998
 
 $UTL/mx null count=1 -all now create=$ARQ.title1 "proc='a11~SHOWrev~a22~SHOWanoP~a65~SHOWanoC~'"
$UTL/mx $ARQ.title1 count=1 lw=0 now ISSN FORMA1

 ###Total igual a zero
 $UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)='' then FORMA2a fi" lw=9999
 ###
  
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalc "9:v1^n" tab=v999
 $UTL/mx $ARQ.totalc "fst=1 0 v1" fullinv=$ARQ.totalc
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalr "5:'Total de revistas'" tab=v999
 
 $UTL/mx $ARQ.mxtbc create=$ARQ.mxtbcST -all now lw=0 "proc='a1111~'ref(['$ARQ.totalc']l(['$ARQ.totalc']v1^n),v999)'~a2222~'ref(['$ARQ.totalr']1,v999)'~a5555~',ref(['$ARQ.arq']1,v5555),'~'" 
 $UTL/mx $ARQ.mxtbcST count=1 now lw=0 FORMA2

 $UTL/mx $ARQ.mxtbcST create=$ARQ.mxtbcg -all now 

 $UTL/mx $ARQ.mxtbcST  now lw=0 "proc='a11~Cited~a1211~AnoC~a230~30_REV~a265~65_ANO~a333~LANG~a5000~FOR1~a7777~'ref(['$ARQ.arq']1,v7777)'~a7766~'ref(['$ARQ.arq']1,v7766)'~'" FORMA3

$UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)<>'' then '</table_list>' fi" 

END


 


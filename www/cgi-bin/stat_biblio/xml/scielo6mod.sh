# **** Citacoes Recebidas ****

BEGIN

$UTL/mx null count=1 -all now create=$ARQ.title1 "proc='a11~SHOWrev~a22~SHOWanoP~a65~SHOWanoC~'"
$UTL/mx $ARQ.title1 count=1 lw=0 now ISSN FORMA1

 $UTL/mxtbansi BASE create=$ARQ.mxtbc uctab=ansi btell=BTELL "bool=BOOLC" "200:e1:=l(['title']v1^c.60),if e1>0 or v1^c='' then '^c',ref(['title']l(['title']v1^t.9),mpu,v100.60,mpl) fi" tab=v999 class=200000
 $UTL/msrt $ARQ.mxtbc 110 v998,v1
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalc "5:'Total'" tab=v999
 
 $UTL/mx $ARQ.mxtbc count=1 now lw=0 "proc='a2222~'ref(['$ARQ.totalc']1,v999)'~'" FORMA2
 
 ###Total igual a zero
 $UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)='' then FORMA2a fi" lw=9999
 ###
 
 $UTL/mx $ARQ.mxtbc create=$ARQ.mxtbcg -all now 
 
 $UTL/mx $ARQ.mxtbcg count=COUNT_SCI now lw=0 "proc='a11~Cited~a1211~AnoC~a1111~'ref(['$ARQ.totalc']1,v999)'~a230~30_REV~a265~65_ANO~a333~LANG~a5000~FOR1~a7777~'ref(['$ARQ.arq']1,v7777)'~a7766~'ref(['$ARQ.arq']1,v7766)'~'" FORMA3

END


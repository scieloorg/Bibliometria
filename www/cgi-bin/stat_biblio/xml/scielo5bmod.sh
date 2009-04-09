# **** Citacoes Concedidas - resultados separados ****

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

 $UTL/mx BASE.PAIS btell=0 "bool=BOOLC" uctab=ansi "tab/tab:999/lines:250000/width:250=if v1^c>'' then '^n'v1^t'^s'ref(['title']l(['title']v1^t),v100),'^c'v1^c.80,'^i',v1^i fi" lw=0 now|sort>$ARQ.mxtbc.seq

$UTL/mx seq=$ARQ.mxtbc.seq create=$ARQ.mxtbc -all now "proc='d*','<1 0>'v3'</1><998 0>'v1'</998><999 0>'v2'</999>'"

 $UTL/msrt $ARQ.mxtbc 110 v1^s,v998
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalc "9:v1^n" tab=v999
 $UTL/mx $ARQ.totalc "fst=1 0 v1" fullinv=$ARQ.totalc
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalr "5:'Total de revistas'" tab=v999
 
 $UTL/mx null count=1 -all now create=$ARQ.title1 "proc='a11~SHOWrev~a22~SHOWanoP~a65~SHOWanoC~a5555~',ref(['$ARQ.arq']1,v5555),'~'"
$UTL/mx $ARQ.title1 lw=0 count=1 now ISSN "pft=@$HOM/scielo5boutXML1a.pft"
 
  ###Total igual a zero
 $UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)='' then ,@$HOM/scielo5boutXML1b2.pft fi" lw=0
 ###
 
 $UTL/mx $ARQ.mxtbc create=$ARQ.mxtbcST -all now lw=0 "proc='a1111~'ref(['$ARQ.totalc']l(['$ARQ.totalc']v1^n),v999)'~a2222~'ref(['$ARQ.totalr']1,v999)'~a5555~',ref(['$ARQ.arq']1,v5555),'~'" 
 $UTL/mx $ARQ.mxtbcST count=1 now lw=0 "pft=@$HOM/scielo5boutXML1b.pft" 
 
 $UTL/mx $ARQ.mxtbcST create=$ARQ.mxtbcg -all now 

 $UTL/mx $ARQ.mxtbcST  now lw=0 "proc='a288~SC_ANO~a265~65_ANO~a333~LANG~a334~PAIS~a5000~FOR1~a7777~'ref(['$ARQ.arq']1,v7777)'~'" "proc='<7766 0>'ref(['lst_traduc']l(['lst_traduc']'COLLECTION_'ref(['title']l(['title']v1^c),mpu,v777[1],mpl)),v1^u)'</7766>'" "pft=@$HOM/scielo5boutXML1c.pft" 

 $UTL/mx null count=1 now lw=0 "pft=if ref(['$ARQ.mxtbc']1,v1)<>'' then '</table_list>' fi" 

echo "</root>" 

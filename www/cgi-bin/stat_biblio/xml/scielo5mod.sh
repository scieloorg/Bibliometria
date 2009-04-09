# **** Citacoes Concedidas ****

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

$UTL/mx null count=1 -all now create=$ARQ.title1 "proc='a11~SHOWrev~a22~SHOWanoP~a65~SHOWanoC~'"
$UTL/mx $ARQ.title1 lw=0 count=1 now ISSN "pft=@$HOM/scielo5outXML1a.pft"

 $UTL/mx BASE.PAIS btell=0 "bool=BOOLC" uctab=ansi "tab/tab:999/lines:250000/width:250=if v1^c>'' then '^c',mpu,v1^c.80,'^i',v1^i fi" lw=0 now|sort>$ARQ.mxtbc.seq

$UTL/mx seq=$ARQ.mxtbc.seq create=$ARQ.mxtbc -all now "proc='d*','<1 0>'v3'</1><998 0>'v1'</998><999 0>'v2'</999>'"

 #$UTL/msrt $ARQ.mxtbc 110 v998,v1
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalc "5:'Total de citações'" tab=v999
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalr "5:'Total de revistas'"
 
 ###Total igual a zero
 $UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)='' then ,@$HOM/scielo5outXML1b2.pft fi" lw=0
 ###
 $UTL/mx $ARQ.mxtbc count=1 now lw=0 "proc='a1111~'ref(['$ARQ.totalc']1,v999)'~a2222~'ref(['$ARQ.totalr']1,v999)'~'" "pft=@$HOM/scielo5outXML1b.pft" 
 $UTL/mx $ARQ.mxtbc create=$ARQ.mxtbcg -all now 
 
 $UTL/mx $ARQ.mxtbcg count=COUNT_SCI now lw=0 "proc='a1111~'ref(['$ARQ.totalc']1,v999)'~a280~SC_REV~a288~SC_ANO~a265~65_ANO~a333~LANG~a334~PAIS~a5000~FOR1~a7777~'ref(['$ARQ.arq']1,v7777)'~'" "proc='<7766 0>'ref(['lst_traduc']l(['lst_traduc']'COLLECTION_'ref(['title']l(['title']v1^I),mpu,v777[1],mpl)),v1^u)'</7766>'" "pft=@$HOM/scielo5outXML1c.pft" 

echo "</citation_list></table></table_list></root>" 

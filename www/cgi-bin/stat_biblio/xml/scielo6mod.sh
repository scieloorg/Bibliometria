# **** Citacoes Recebidas ****

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

$UTL/mx null count=1 -all now create=$ARQ.title1 uctab=ansi "proc='a11~SHOWrev~a22~SHOWanoP~a65~SHOWanoC~'" 
$UTL/mx $ARQ.title1 count=1 lw=0 now ISSN "pft=@$HOM/scielo6outXML1a.pft"

 $UTL/mx BASE.PAIS btell=0 "bool=BOOLC" uctab=ansi "tab/tab:999/lines:250000/width:250='^c',ref(['title']l(['title']v1^t.9),mpu,v100.80,mpl)" lw=0 now|sort>$ARQ.mxtbc.seq

$UTL/mx seq=$ARQ.mxtbc.seq create=$ARQ.mxtbc -all now "proc='d*','<1 0>'v3'</1><998 0>'v1'</998><999 0>'v2'</999>'"

 #$UTL/msrt $ARQ.mxtbc 80 v1
 
 $UTL/mxtb $ARQ.mxtbc create=$ARQ.totalc "5:'Total'" tab=v999
 
 $UTL/mx $ARQ.mxtbc count=1 now lw=0 "proc='a2222~'ref(['$ARQ.totalc']1,v999)'~'" "pft=@$HOM/scielo6outXML1b.pft"
 
 ###Total igual a zero
 $UTL/mx null count=1 now  "pft=if ref(['$ARQ.mxtbc']1,v1)='' then ,@$HOM/scielo6outXML1b2.pft fi" lw=0
 ###
 
 $UTL/mx $ARQ.mxtbc create=$ARQ.mxtbcg -all now 
 
 $UTL/mx $ARQ.mxtbcg count=COUNT_SCI now lw=0 "proc='a11~Cited~a1211~AnoC~a1111~'ref(['$ARQ.totalc']1,v999)'~a230~30_REV~a265~65_ANO~a333~LANG~a5000~FOR1~a7777~'ref(['$ARQ.arq']1,v7777)'~'" "proc='<7766 0>'ref(['lst_traduc']l(['lst_traduc']'COLLECTION_'ref(['title']l(['title']v1^c),mpu,v777[1],mpl)),v1^u)'</7766>'" "pft=@$HOM/scielo6outXML1c.pft"

echo "</citation_list></table></table_list></root>"

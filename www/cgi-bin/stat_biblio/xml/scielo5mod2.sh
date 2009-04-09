# **** Citacoes Concedidas - ver formas citadas ****

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

$UTL/mx null create=$ARQ.list2 count=0
	  
$UTL/mx artc.PAIS append=$ARQ.list2 btell=BTELL "bool=BOOL" -all now

$UTL/mx $ARQ.list2 "tab/width:100=v30/" lw=0 now|sort>$ARQ.list3.seq

#$UTL/msrt $ARQ.list3 10 v998

$UTL/mx null count=1 uctab=ansi "proc='a44~Cited~'" now "pft=@$HOM/scielo5outXML2a.pft"

$UTL/mx seq=$ARQ.list3.seq "pft=@$HOM/scielo5outXML2b.pft" lw=0 now

echo "</citation_form_list></root>"


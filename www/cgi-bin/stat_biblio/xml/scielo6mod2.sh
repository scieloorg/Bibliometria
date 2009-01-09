BEGIN

#Se HTML, gera título
$UTL/mx null count=1 now "proc='a9~Citante~a11~SHOWrev~a65~AnoC~'" FORMA1

$UTL/mx null create=$ARQ1.list2 count=0
	  
$UTL/mx artigoc uctab=ansi append=$ARQ1.list2 btell=BTELL "bool=BOOL" -all now

$UTL/msrt $ARQ1.list2 40 v65.4,v31,v32

$UTL/mx $ARQ1.list2 uctab=ansi FORMA2 lw=0 now

END
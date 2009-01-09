# **** Citacoes Concedidas - ver formas citadas ****

BEGIN

$UTL/mx null create=$ARQ1.list2 count=0
	  
$UTL/mx artigoc append=$ARQ1.list2 btell=BTELL "bool=BOOL" -all now

$UTL/mxtb $ARQ1.list2 create=$ARQ1.list3 "100:v30/" class=10000
#$UTL/mxtbansi $ARQ1.list2 create=$ARQ1.list3  uctab=ansi "100:proc('d*<30 99>'v30'</30><33 99>'f(99999-size(v30),1,0)'</33>'), v33,'^t', v30/" class=10000

$UTL/msrt $ARQ1.list3 10 v998

$UTL/mx null count=1 uctab=ansi "proc='a44~Cited~'" now FORMA1

$UTL/mx $ARQ1.list3 FORMA2 lw=0 now

END


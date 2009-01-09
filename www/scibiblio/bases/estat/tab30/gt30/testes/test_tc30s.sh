echo "tc30issn - do diretório arrumada"

CIPAR=../../../cipar.cip; export CIPAR
LIND="/utl/lind"

$LIND/mxtbansi artigoc create=teste.mxtbc uctab=ansi btell=0 "bool=$" "200:if p(v30) and a(v18) then proc('d30<30 99>',e1:=l(['../tc30issn']mpu,v30,mpl),if e1>0 then ref(['../tc30issn']e1,if p(v222^a) then mpu,v222^a,'^i',if v400>'' then v400 else, if v22^a>'' then v22^a else v22 fi, fi, else if p(v2) then '~~2_'v2 else '~~1_'v30 fi fi,mpl) else '~~*_'v30 fi,'</30>'),proc('d30<400 99>'v30^i'</400><30 99>',e1:=l(['tab30isi']v30^*),if e1>0 then ref(['tab30isi']e1,mpu,v2,mpl) else v30^* fi,'</30>'),if v30>'' then '^c',mpu,v30.60, '^i', v400 fi fi" class=100000 
 
$LIND/msrt teste.mxtbc 110 v998,v1

$LIND/mxtb teste.mxtbc create=teste.totalc "5:'Total de citações'" tab=v999
 
$LIND/mxtb teste.mxtbc create=teste.totalr "5:'Total de revistas'"
 
 ###### Para controle da tabela de conversão de títulos 
$LIND/mx teste.mxtbc -all now lw=9999 "pft=v999,'|',e1:=l(['../tc30issn']ref(['../tc30issn']l(['../tc30issn']v1^c),v400)),e2:=l(['fat_imp']v1^c),e3:=l(['titlelilmdl']'LL_'v1^c),e4:=l(['titlelilmdl']'IM_'v1^c),if e1>0 or e2>0 or e3>0 or e4>0 then proc('a2~'if e1>0 then ',SciELO ' fi,if e2>0 then ',ISI ' fi,if e3>0 then ',LILACS ' fi,if e4>0 then ',MEDLINE ' fi'~'),v2*1 else, if v1^c.2:'~~' then 'arrumar' else '-' fi,fi,'|'v1^c/" >teste.confere.seq

#mx teste.mxtbc -all now lw=9999 "pft=v999,'|',e1:=l(['../tc30issn']ref(['../tc30issn']l(['../tc30issn']v1^c),v400)),e2:=l(['fat_imp']v1^c),if e1>0 and e2>0 then 'SciELO / ISI|',v1^c else if e1>0 then 'SciELO|',v1^c else if e2>0 then 'ISI|',v1^c else if v1^c.2:'~~' then 'arrumar1|' else if v1^c.3:'~~*' then 'arrumar2|' else if v1^c='' then '-|Não identificadas' else '-|',v1^c fi fi fi fi fi fi/" >teste.confere.seq

$LIND/mx seq=teste.confere.seq create=teste.confere -all now 
$LIND/mxtb teste.confere create=teste.freq "45:v2" tab=v1 
$LIND/msrt teste.freq 110 v1
$LIND/mxtb teste.freq create=total.freq "1:'total'" tab=v999
$LIND/mx teste.freq now "proc='a1111~'ref(['teste.totalc']1,v999)'~'" "pft=@scielo5out.pft"
#>test_tc30s.txt
$LIND/mx null count=1 "pft='************************'/'TOTAL',c15,f(val(ref(['total.freq']1,v999)),7,0),c30,'100%'/"
#>>test_tc30s.txt
 ######

$LIND/mx teste.mxtbc count=1 now lw=9999 "proc='a1111~'ref(['teste.totalc']1,v999)'~a2222~'ref(['teste.totalr']1,v999)'~'" "pft=@scielo5out1b.pft" 
#>>test_tc30s.txt
$LIND/mx teste.mxtbc create=teste.mxtbcg -all now 

$LIND/mx teste.mxtbcg count=20 now lw=9999 "proc='a1111~'ref(['teste.totalc']1,v999)'~'" "pft=@scielo5out1c.pft" 
#>>test_tc30s.txt

unset CIPAR

echo "#########################  FIM  #########################"

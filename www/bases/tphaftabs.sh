
## tphaftabs.sh -
## Tabelas
##

cd tabs

#grep "^    See"  ../tabs/wikicountries.txt >wikicountries.See.txt
#grep "^   [A-Z]" ../tabs/wikicountries.txt >wikicountries.txt.txt
#../mx "seq=wikicountries.txt.txt[" "proc='Gsplit/clean=1=.'" "proc='d*a1|'v1[1]'|',|<2>|v1[2]|</2>" "proc='Gsplit/clean=1=('" "proc='d1a1|'v1[1]'|'"  "proc='Gsplit/clean=2=('" "proc='d2',|<50>|v2[1]|</50>" "proc=e1:=l->tabpais(v1),if e1=0 then e1:=l->tabpais(v50) fi,if e1>0 then ref->tabpais(e1,'a20|'v20'|') fi" -all now create=wikicountries

##
# tabela de paises
../mx iso=tabpais.iso -all now create=tabpais
../mx tabpais uctab=ansi "fst=1 0 v20/v1/v2/v3/(v50/)(v950/),'AL='v30" fullinv=tabpais

##
#http://www.insidervlv.com/citylargestWorld.html
#http://www.citymayors.com/features/euro_cities1.html
#http://www.citymayors.com/features/euro_cities5.html
#http://www.citymayors.com/gratis/uscities_100.html
#http://www.citymayors.com/gratis/uscities_200.html

#http://www.citymayors.com/features/largest_cities.html
#http://www.citymayors.com/features/largest_cities1.html
#http://www.citymayors.com/features/largest_cities_2.html
#http://www.citymayors.com/features/largest_cities_3.html


../mx tabpais "proc='d*<1> 'v2' </1><2>|'v20'|</2>'" -all now create=xgiz
../mx seq=largest_cities.txt uctab=ansi "proc='<2>'v1'</2>'" "proc='Gsplit=2= '"  "proc=|<3>|v2|</3>|"  "proc='d3/1'" "proc='d3/'f(nocc(v3),1,0)" "proc='d3<3>'mpu,v3| |'</3>'" "proc='Gxgiz,3'" "proc='Gsplit=3=|" "proc='d1d3<1>'v3[1]'</1>',|a20~|v3[2]|~|" -all now create=tablarg
../mx tablarg "fst=1 0 if p(v20) then v1/'P='v20 fi" fullinv=tablarg

##
# tabela de cidades
../mx tablarg -all now create=tabcida
../mx seq=wikicities100kSA.txt uctab=ansi "proc=if p(v2) then 'd*',putenv('PAIS='ref->tabpais(l->tabpais(v2),v20)) else 'a20|'getenv('PAIS')'|' fi"  "proc=if l->tablarg(v1)>0 then 'd*' fi" -all now append=tabcida
../mx tabcida uctab=ansi "fst=1 0 v1/'P='v20" fullinv=tabcida

exit

___________________________________________________________________________________________________________
PX1:/bases/org.000>

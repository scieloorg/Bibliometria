
## tphaf.afevid.sh - 
## Afiliacao via distribuicao de pares paisok-instituicao, paisok-instituto, paisok-faculdade, paisok-depto
##

#mkdir $1
#cd $1
mkdir afp
cd afp

echo  > mx_what.sh
../mxcisis null "pft=e1:=l(['../artigo/artigo']'TP=H'),if e1>0 then 'cp ../mxcisis ../mx'/'cp ../mxtbcisis ../mxtb'/'cp ../msrtcisis ../msrt'/ fi" now count=1 >>mx_what.sh
../mxlind null "pft=e1:=l(['../artigo/artigo']'TP=H'),if e1>0 then 'cp ../mxlind ../mx'/'cp ../mxtblind ../mxtb'/'cp ../msrtlind ../msrt'/ fi" now count=1 >>mx_what.sh
sh -x mx_what.sh

../mx ../artigo/artigo iso=../artigos.iso -all now "TP=H" "proc=if p(v32701) then 'R../artigo/',v32701^*,',',v32701^m',' fi"
cp ../mxlind ../mx
cp ../mxtblind ../mxtb
cp ../msrtlind ../msrt
../mx iso=../artigos.iso create=../artigos -all now

echo / >tphaf.cip
echo artigos.*=../artigos.*>>tphaf.cip
echo tabpais.*=../tabs/tabpais.*>>tphaf.cip
echo tabcida.*=../tabs/tabcida.*>>tphaf.cip
echo join700a.pft=../tabs/join700a.pft>>tphaf.cip
echo join700b.pft=../tabs/join700b.pft>>tphaf.cip
echo join710a.pft=../tabs/join710a.pft>>tphaf.cip
export CIPAR=tphaf.cip


##
# pares afiliacao - cidade valida
# extrai pares
#../mx artigos "pft=(e1:=l->tabcida(v70^c),if e1>0 then s1:=(v880[1]^c'|'mfn(1)'|'ref->tabcida(e1,v20)'|'), s1,v70^*'|0|'v70^c/ fi)" lw=0 now tell=10000 >tbstc.txt
#head tbstc.txt
#wc -l tbstc.txt

##
# pares afiliacao-pais valido ou pais via cidade valida

# extrai pares
../mx artigos "pft=(e1:=l->tabpais(v70^p),if e1>0 then s1:=(v880[1]^c'|'mfn(1)'|'ref->tabpais(e1,v20)'|'), s1,v70^*'|0'/ else e1:=l->tabcida(v70^c),if e1>0 then s1:=(v880[1]^c'|'mfn(1)'|'ref->tabcida(e1,v20)'|'), s1,v70^*'|0|'v70^c/ fi fi)" lw=0 now tell=10000 >tbsts.txt
 head tbsts.txt
 wc -l tbsts.txt

# tabula ocorrencias mantendo letras e espacos
../mx seq=tbsts.txt  uctab=ansi "tab=proc('Gsplit=4=letters'),mpu,v3' 'v4+| |" lw=0 now tell=10000 >tbstp.txt

#ordena desc por frequencia
sort -o tbstp.txt tbstp.txt
 head tbstp.txt
 wc -l tbstp.txt

# cria tabela ocorrencias
../mx seq=tbstp.txt -all now create=tbstp
../mx tbstp  "fst=1 0 v3*3" fullinv=tbstp
../mx dict=tbstp "pft=v1^*,c62,f(val(v1^t),9,0)/" now |head


##
# seleciona 83pc 1obs 
#../mx dict=tbstp,11,12 "join=tbstp,2,3=(|mfn=|v12^m/)" "proc='d1001d1002d32001d12'" "proc='a40|'f(rsum(v2+| |),1,0)'|'" "proc='a4|'f(val(v2[1])/val(v40),8,6)'|'" "proc='a5|'if v4>='0.83' and val(v2[1])=1 then 'yes' else 'not' fi'|'" -all now create=tbstpi1 tell=10000
#../msrt tbstpi1 10 "f(99999999-val(v2[1]),9,0)"
#../mx tbstpi1 "fst=1 0 '.pais='v3[1].2/,'.n='v2[1]/,'.t='v40/,'.cut='v4.4/,'.get='v5/,if v5='yes' then else '-' fi,v11^*" fullinv=tbstpi1

##
# seleciona 83pc $2obs 
../mx dict=tbstp,11,12 "join=tbstp,2,3=(|mfn=|v12^m/)" "proc='d1001d1002d32001d12'" "proc='a40|'f(rsum(v2+| |),1,0)'|'" "proc='a4|'f(val(v2[1])/val(v40),8,6)'|'" "proc='a5|'if v4>='0.83' and val(v2[1])>=1 then 'yes' else 'not' fi'|'" -all now create=tbstpi tell=10000
../msrt tbstpi 10 "f(99999999-val(v2[1]),9,0)"
../mx tbstpi "fst=1 0 '.pais='v3[1].2/,'.n='v2[1]/,'.t='v40/,'.cut='v4.4/,'.get='v5/,if v5='yes' then else '-' fi,v11^*" fullinv=tbstpi

 ../mx dict=tbstpi "pft=v1^*,c62,f(val(v1^t),6,0)/" now k1=. k2=. | head -5
 ../mx dict=tbstpi "pft=v1^*,c62,f(val(v1^t),6,0)/" now k1=. k2=. | tail -5
 ../mx      tbstpi                                  now count=1
 ../mx      tbstpi "pft=v2[1]' 'v40' 'v4' 'v3[1]/" lw=0 now "UNIVERSIDADE DE SAO PAULO"
 ../mx      tbstpi "pft=v2[1]' 'v40' 'v4' 'v3[1]/" lw=0 now "USP"
 ../mx      tbstpi "pft=v2[1]' 'v40' 'v4' 'v3[1]/" lw=0 now ".get=yes" count=5
 ../mx      tbstpi "pft=v2[1]' 'v40' 'v4' 'v3[1]/" lw=0 now ".get=not" count=5



##
# pais ausente/invalido afiliacao via tbstpi
../mx null count=1  lw=0 now "pft='../mx artigos uctab=ansi proc=@join700a.pft proc=@join700b.pft -all now create=org700 tell=10000'/" >xtphaf700.sh
# run
sh -x xtphaf700.sh

# afiliacao para cada autor
../mx null count=1               lw=0 now "pft='../mx null count=0 create=org710'/" >xtphaf710.sh
../mx null count=1000 loop=10000 lw=0 now "pft=if mfn<=val(ref->org700(1,f(maxmfn,1,0))) then '../mx org700 proc=@join710a.pft -all now copy=org710 count=10000 from='mfn(1)/ fi" >>xtphaf710.sh 
# run
sh -x xtphaf710.sh



##
# list
../mx org710 "tab=(if p(v710) then if v710^0*1>'' then v710^0*1 else '--' fi/ fi)" lw=0 -all now tell=20000|sort>x2t
../mx seq=x2t join=tabpais,4:1=v3.2 "pft=v1,v4.60,c70'|'v2'|'v3'|'v4/" lw=0 now |sort>x2s
../mx seq=x2s "pft=f(mfn,9,0)'|'v2'|'v3'|'v4/" lw=0 now >x2
head x2

 
../mx org710 "tab/lines:900000=(if p(v710) then if v710^0*1>'' then v710^0*1 else '--' fi,x1,mpl,v710^*/ fi)" lw=0 -all now tell=20000 uctab=ansi |sort>x3t
../mx seq=x3t join=tabpais,4:1=v3.2 "pft=v1,v4.60,c70'|'v2'|'v3'|'v4/" lw=0 now |sort>x3s
../mx seq=x3s "pft=f(mfn,9,0)'|'v2'|'v3'|'v4/" lw=0 now >x3
head x3

 ../mx seq=x3 "pft=f(mfn,9,0)'|'v2'|'v3/" lw=0 now count=10

#../mx org710              "pft=(if p(v710) then if v710^0*1>'' then v710^0*1 else '--' fi,x1,mpl,v710^*/ fi)" lw=0 -all now tell=20000 uctab=ansi >x300
#../mx seq=x300 -all now create=x300
#../mxtb x300 create=x30 "100:mpl,v1" class=900000 tell=60000 
#../mx x30 lw=0 now "pft=v998'|'v999'|'v1/" now |sort>x30
# diff x3 x30|wc -l

../mx seq=x3 "pft=if v3.2='--' then      v1'|'v2'|'v3'|'v4/ fi" lw=0 now >xnot
../mx seq=x3 "pft=if v3.2='--' then else v1'|'v2'|'v3'|'v4/ fi" lw=0 now >xyes
../mx seq=x3 "pft=                       v1'|'v2'|'v3'|'v4/   " lw=0 now >xall
wc -l xnot xyes xall
../mx seq=xnot "tab/tab:2='total'" -all now
../mx seq=xyes "tab/tab:2='total'" -all now
../mx seq=xall "tab/tab:2='total'" -all now

##
# xls text files

 mkdir xls
 
../mx seq=x2 "pft=v1'|'v2'|'v3'|'v4/" lw=0 now >xls/pall.xls
../mx seq=x3 "pft=v1'|'v2'|'v3'|'v4/" lw=0 now >xls/piall.xls
 
../mx seq=x3 "pft=if v3.2<>'BR' and v3.2<>'--' then v1'|'v2'|'v3'|'v4/ fi" lw=0 now >xls/pibrot.xls
  
../mx seq=x2 "pft=\`../mx seq=x3 \"pft=if v3.2='\`v3\`' then v1'|'v2'|'v3'|'v4/ fi\" lw=0 now >xls/pi\`v3\`.xls\`/" lw=0 now >x3xls.sh
 sh -x x3xls.sh 

exit

   7287 xnot
  14373 xyes
  21660 xall
  43320 total
PX1:/bases/org.000/3>../mx seq=xnot "tab/tab:2='total'" -all now
999956226|43773|total
PX1:/bases/org.000/3>../mx seq=xyes "tab/tab:2='total'" -all now
999740851|259148|total
PX1:/bases/org.000/3>../mx seq=xall "tab/tab:2='total'" -all now
999697078|302921|total
C:\SciELO>calc0 259148/302921
Expr: 259148/302921
Resp: 0.86

 ../mx seq=x3 "pft=v1'|'v2'|'v3'|'v4/" lw=0 now |grep "JULIO MESQ"|head -3
 ../mx seq=x3 "pft=v1'|'v2'|'v3'|'v4/" lw=0 now |grep "JULIO DE MESQ"|head -3
 
 ________________________________________________________________________________
##
# trig
 ../mxff seq=xyes -all now create=xyes
 ../mxff seq=xnot -all now create=xnot
 ../wtrig1 documents=xyes                 extract=2 case=ansi bin dmfn tell=1000
 ../wtrig1 documents=xnot collection=xyes extract=2 case=ansi bin      tell=1000
 ../mxff xyes.v +control count=0
 ../mxff xnot.v +control count=0
 ../wtrig2 documents=xnot,xnot80 collection=xyes maxrel=1 minsim=0.80 loadvectors loadindex cmfn=1 tell=1000
 ../mxff xnot "join=xnot80.y='mfn='mfn" "join=xyes:10=|mfn=|v6^*" "pft=v3,c8,v1' 'v2/,if v6^s>='0.80' and v6^s<='1.00' and size(v2)>1 then v13,c8,v11.3' 'v12/,c12,v6^s.4/ fi#" lw=0 now count=10
  
exit

##
  diff 1/xyes 2/xyes|grep -v "[0-9,-][a,d,c,-][0-9,-]"|head
  ./mx seq=1/xyes lw=0 "pft=v1'|'v2/" now >xyes1
  ./mx seq=2/xyes lw=0 "pft=v1'|'v2/" now >xyes2
  diff xyes1 xyes2|grep -v "[0-9,-][a,d,c,-][0-9,-]">x
  ./mx seq=x: lw=0 "pft=if v1.1='<' then v1*1/ fi" now |sort>xlt
  ./mx seq=x: lw=0 "pft=if v1.1='>' then v1*1/ fi" now |sort>xgt
  head -5 xlt
  head -5 xgt
  diff xlt xgt|grep -v "[0-9,-][a,d,c,-][0-9,-]">xx
  ./mx seq=xx: lw=0 "pft=if v1.1='<' then v1*1/ fi" now count=5
  ./mx seq=xx: lw=0 "pft=if v1.1='>' then v1*1/ fi" now count=5

exit  


________________________________________________________________________________
# procs -

/*
700 = v70 precedido de codigo de pais
      -               = missing
      codpais^0p Pais = codpais dado 
      codpais^0i Inst = codpais via tbstpi 
      ^i A1
      ^7 v70
 880 = v880
 123 = v123
 10  = v10
 70  = v70

*/
 

cat >tabs/join700a.pft
 'd*'
 |<880 200>|v880|</880>|,
 |<123 200>|v123|</123>|,
 |<10 200>|v10|</10>|,
 |<70 200>|v70|</70>|,

 (if p(v70) then 
   if iocc>30 then break fi
   '<700 200>'
        if p(v70^*) then                           
                          proc('d7<7 200>',mpu,v70^*,mpl,'</7>')
                          putenv('XAF='v7[1]),proc('d7<7 0>'ref->null(1,proc('<1>',getenv('XAF')'</1>'),proc('Gsplit=1=letters'),v1+| |)'</7>')
                          ''  v7[1],
                              e1:=l->tbstpi(v7[1])
                              if e1>0 then ref->tbstpi(e1,if val(v4)>=0.90 or size(v11^*)>3 and val(v4)>=0.83 then '^w'v3[1].2 fi) fi
        fi
        if p(v70^1) then                           
                          proc('d7<7 200>',mpu,v70^1,mpl,'</7>')
                          putenv('XAF='v7[1]),proc('d7<7 0>'ref->null(1,proc('<1>',getenv('XAF')'</1>'),proc('Gsplit=1=letters'),v1+| |)'</7>')
                          '^1'v7[1],
                              e1:=l->tbstpi(v7[1])
                              if e1>0 then ref->tbstpi(e1,if val(v4)>=0.90 or size(v11^*)>3 and val(v4)>=0.83 then '^x'v3[1].2 fi) fi
        fi
        if p(v70^2) then                           
                          proc('d7<7 200>',mpu,v70^2,mpl,'</7>')
                          putenv('XAF='v7[1]),proc('d7<7 0>'ref->null(1,proc('<1>',getenv('XAF')'</1>'),proc('Gsplit=1=letters'),v1+| |)'</7>')
                          '^2'v7[1],
                              e1:=l->tbstpi(v7[1])
                              if e1>0 then ref->tbstpi(e1,if val(v4)>=0.90 or size(v11^*)>3 and val(v4)>=0.83 then '^y'v3[1].2 fi) fi
        fi
        if p(v70^3) then                           
                          proc('d7<7 200>',mpu,v70^3,mpl,'</7>')
                          putenv('XAF='v7[1]),proc('d7<7 0>'ref->null(1,proc('<1>',getenv('XAF')'</1>'),proc('Gsplit=1=letters'),v1+| |)'</7>')
                          '^3'v7[1],
                              e1:=l->tbstpi(v7[1])
                              if e1>0 then ref->tbstpi(e1,if val(v4)>=0.90 or size(v11^*)>3 and val(v4)>=0.83 then '^z'v3[1].2 fi) fi
        fi
        if p(v70^p) then                           
                          '^p'mpu,v70^p,mpl,
                              e1:=l->tabpais(v70^p)
                              if e1>0 then ref->tabpais(e1,'^q'v20) fi
        fi
        if p(v70^c) then                           
                          '^c'mpu,v70^c,mpl,
                              e1:=l->tabcida(v70^c)
                              if e1>0 then ref->tabcida(e1,'^b'v20) fi
        fi
        '^i'if v70^i>'' then v70^i.1,f(val(v70^i*1),1,0) fi,
    '</700>' 
   fi
  )



cat >tabs/join700b.pft
 
 'd700'
 (if p(v700) then 
   '<700 0>'
      if v700^w>'' then v700^*,'^00'v700^w else
      if v700^x>'' then v700^*,'^01'v700^x else
      if v700^y>'' then v700^*,'^02'v700^y else
      if v700^z>'' then v700^*,'^03'v700^z else
      if v700^q>'' then v700^*,'^0p'v700^q else
      if v700^b>'' then v700^*,'^0c'v700^b else
      v700^*,'^0-'
      fi fi fi fi fi fi 
      '^7'v700
    '</700>' 
   fi
  )

  
  
cat >tabs/join710a.pft
/* 
710 = v70 precedido de codigo de pais e v10 precedido de A01 normalizado
      -               = missing
      codpais^0p Pais = codpais dado 
      codpais^0i Inst = codpais via tbstpi 
      ^i A1
      ^7 v70
      |^r|v10^r,
      |^n|v10^n,
      |^s|v10^s,
*/
   proc('d710'
     (if p(v10) then 
       if iocc>100 then break fi
       '<710 0>'
         putenv('X101='if v10^1>'' then v10^1.1,f(val(v10^1*1),1,0) else '-' fi)
         ref(mfn,
           s1:=(getenv('X101')),
           (if p(v700) then 
             if iocc>100 then break fi
             if v700^i=s1 then v700,break fi
            fi
           )
         )
         |^r|v10^r,
         |^n|v10^n,
         |^s|v10^s,
       '</710>' 
      fi
     )
   )

________________________________________________________________________________




cat >tphaftabs.sh

## tphaftabs.sh - 
## Tabelas
##

cd tabs

#grep "^    See"  wikicountries.txt >wikicountries.See.txt
#grep "^   [A-Z]" wikicountries.txt >wikicountries.txt.txt
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


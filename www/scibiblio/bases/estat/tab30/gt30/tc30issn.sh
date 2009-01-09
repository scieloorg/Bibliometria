# -------------------------------------------------------------------------- #
# gencorrtc30 - Gera Tabela de Correcao do Tit Citado
# -------------------------------------------------------------------------- #
#     entrada :
#       saida :
#    corrente : ???/www/scibiblio/bases/estat/tab30/gt30
# observacoes :
# -------------------------------------------------------------------------- #
# DATA      RESP              Comantarios
# 20040616  Rogerio / Chico   Edicao original
#

# -------------------------------------------------------------------------- #
echo "*********************************************************************************************"
echo "******           SHELL PARA GERAÇÃO DA BASE DE CORREÇÃO DE TÍTULOS DE REVISTAS:        ******"
echo "******                   campo v30 da base Scielo Cuba - artigo                       ******"
echo "*********************************************************************************************"
echo "*******  Cipar, bases e geração de arquivos invertidos das bases a serem utilizadas   *******"
echo "*********************************************************************************************"
CIPAR=../../cipar.cip; export CIPAR

CISIS="/utl/cisis"
CISIS1660="/utl/cisis1660"
LIND="/utl/lind"
FFI="/utl/cisis1660ffi"
LINDFFI="/utl/lindffi"

echo "*   Conta citações já tabuladas [ contav30 ]a artigos de revista [ p(v30) and a(v18) ]   *"
$LIND/mxtbansi artigoc create=contav30 bool=$ uctab=ansi "150:if p(v30) and a(v18) then mpu,v30 fi" btell=0 class=90000
$LIND/msrt contav30 10 v998
#mx contav30 "fst=1 0 ref(['tab30issn']l(['tab30issn']v1),v222^a)" fullinv/ansi=contav30

echo "*********************************************************************************************"

echo "******** Parte 1 - Gera base TC30SCIELO, utilizando os dados da TITLE SciELO  *******"

$LIND/mx ../../jcr/title uctab=ansi create=tc30scielo -all now "proc='d*a100~',mpu,v100,'~',if p(v110) then 'a110~'v100' - 'v110'~a111~'v100'-'v110'~' fi,'a150~',mpu,v150,mpl'~',if p(v151) then 'a151~',mpu,v151,mpl'~' fi,'a222~^a',mpl,v100,'^bSCIELO~a400~'v400'~'"
$LIND/mx tc30scielo "fst=@tc30scielo.fst" fullinv/ansi=tc30scielo

echo "*********************************************************************************************"

echo "*****    Parte 2 -         Gera base de correção de títulos   TAB30ISSN_CORRECT         *****"

echo "***  Gera FASE 1 da base de correção de títulos, com títulos escritos como nna base ISSN  ***"

echo "**        Seleciona citações já tabuladas, com Match=1 na base do ISSN [ fastissn ]        **"
$LIND/mx null count=0 create=fase1
$LIND/mx contav30 create=pre_fase1 "proc=if f(npost(['fstissn']replace(replace(replace(s(mhu,v1,mpl),'  ',' '),'.',' '),'  ',' ')),1,0)='1' then 'd1d998d999a1~'ref(['fstissn']l(['fstissn']replace(replace(replace(s(mhu,v1,mpl),'  ',' '),'.',' '),'  ',' ')),mfn)'~a222~'ref(['fstissn']l(['fstissn']replace(replace(replace(s(mhu,v1,mpl),'  ',' '),'.',' '),'  ',' ')),v222)'~a22~'ref(['fstissn']l(['fstissn']replace(replace(replace(s(mhu,v1,mpl),'  ',' '),'.',' '),'  ',' ')),v22^a)'~a29~'mfn'~a30~'v1'~a999~'v999'~' else 'd*' fi" -all now
$LIND/mx pre_fase1 append=fase1 -all now
rm pre_fase1.*

echo "*** Gera FASE 2 da base de correção de títulos, utilizando inversão palavra por palavra   ***"
echo "**     Geração de expressões de busca (palavra por palavra) para recuperação na base       **"

$LIND/mx null count=0 >nullstw.tab
$LIND/mx null count=0 create=fase2_tabout2

echo "**                  Monta Shell c/ expressões de busca palavra-a-palavra                   **"
$LIND/mx contav30 uctab=ansi "jchk=null+nullstw.tab=mpu,v1" "pft='$LIND/mx fstissn2 btell=0  \"bool='(if p(v32001) then v32001^k'$',if iocc<nocc(v32001) then ' * ' fi fi),'\" +hits \"proc=if val(v1002)>1 then #%#d*#%# else #%#d*a1~#%#mfn#%#~a222~#%#v222#%#~a29~^c'mfn'~#%# fi\" append=fase2_tabout2 -all now'/"  lw=999 -all now>savehits2.txt

echo "!ID 000000">giz2.id
echo "!v001!035037035">>giz2.id
echo "!v002!039">>giz2.id
echo "!v011!asc">>giz2.id
echo "!v021!asc">>giz2.id
$LIND/id2i giz2.id create=giz2
$LIND/mx seq=savehits2.txt create=work gizmo=giz2,1 -all now
$LIND/mx work "pft=v1/" lw=999 -all now>savehits2.txt
rm work.* giz2.*
\. savehits2.txt
rm savehits2.txt

echo "**                        Formata a base fase2_tabout2                                     **"
$LIND/mx fase2_tabout2 create=fase2_join1issnWW -all now "proc='d29a22~'ref(['fstissn']val(v1),v22^a)'~a29~'v29^c'~a30~'ref(['contav30']val(v29^c),v1)'~a999~'ref(['contav30']val(v29^c),v999)'~'"
rm fase2_tabout2.*

echo "**               Seleciona registros excludentes entre as bases das FASES 1 e 2            **"
$LIND/mx fase1 "fst=1 0 v29" fullinv=fase1 tell=5000
$LIND/mx fase2_join1issnWW "join=fase1=v29" create=fase2_fstissn_tabout2 -all now
rm fase2_join1issnWW.*

echo "**          Seleciona (da base_FASE 2) citações tabuladas excludentes das FASE 1           **"
$LIND/mx null create=fase2_complementar count=0
$LIND/mx fase2_fstissn_tabout2 append=fase2_complementar -all now "proc=if p(v32001^m) then 'd*' else 'd32001' fi"
rm fase2_fstissn_tabout2.*

echo "**                              Appenda as bases da FASES 1 e 2                            **"
$LIND/mx null create=tab30issn_correct count=0
$LIND/mx fase1 append=tab30issn_correct -all now
$LIND/mx fase2_complementar append=tab30issn_correct -all now
rm fase2_complementar.* fase1.*

echo "*********************************************************************************************"


echo "*****   Parte 3 -  Corrige títulos menos citados por mais citados similares - TRIGRAMA  *****"
echo "*****               e aplica base de correção TAB30ISSN_CORRECT                         *****"

$LIND/mx tab30issn_correct iso=tab30issn_correct.iso -all now
$CISIS1660/mx iso=tab30issn_correct.iso create=tab30issn_correct_1660 -all now
$CISIS1660/mx tab30issn_correct_1660 "fst=1 0 v30" fullinv=tab30issn_correct_1660
rm tab30issn_correct.iso

echo "**                            Começa a gerar base WTRIG_TITLES                             **"
$LIND/mx contav30 iso=tc30.iso -all now
$LINDFFI/mx iso=tc30.iso create=tc30 -all now
rm tc30.iso
$LINDFFI/msrt tc30 10 v998

$LIND/wtrig1 documents=tc30 extract=v1 tell=5000
$LIND/wtrig2 documents=tc30 collection=tc30 maxrel=10 minsim=0.80 loadindex loadvectors tell=1000

$LINDFFI/mx tc30.y "proc='d6',(if v6>'' then '<6 0>'f(val(v6^*),6,0)'^0',v6'</6>'fi)" "proc='s6'" "pft=if size(ref->tc30(mfn,v1)) > 3 then (if val(v6^0)<=mfn and val(v6^s)>0.90 then ref->tc30(mfn,v1),'|',ref->tc30(val(v6^0),v1)'|'mfn(1)'|'v6^0'|'v6^s/,break else ref->tc30(mfn,v1)/,break fi) fi" lw=9999 now tell=10000 >tc30giz_nos.txt

$CISIS1660/mx seq=tc30giz_nos.txt -all now create=tc30giz_nos "proc='d1d2d3d4d5a30~'v1'~a2~'v2'~a3~'v3'~a4~'v4'~a5~'v5'~'"
rm tc30giz_nos.txt tc30.*
$CISIS1660/mx tc30giz_nos -all now create=wtrig_titles jmax=1 "join=tab30issn_correct_1660,22,222=v30" "join=issn,22,222=if v32001^m='' then v30 fi" "join=issn,22,222=if v32001^m='' and v32002^m='' then replace(replace(replace(v30,'  ',' '),'.',' '),'  ',' ') fi" "join=tab30issn_correct_1660,22,222=if v32001^m='' and v32002^m='' and v32003^m='' then v2 fi" "join=issn,22,222=if v32001^m='' and v32002^m='' and v32003^m='' and v32004^m='' then v2 fi" "join=issn,22,222=if v32001^m='' and v32002^m='' and v32003^m='' and v32004^m='' and v32005^m='' then replace(replace(replace(v2,'  ',' '),'.',' '),'  ',' ') fi"
rm tc30giz_nos.* tab30issn_correct*

$LIND/mx wtrig_titles "fst=;1 0 v30;2 0 v22;3 0 v222^a" fullinv/ansi=wtrig_titles tell=5000

echo "**                     Cria base TC30ISSN com TC30SCIELO e WTRIG_TITLES                    **"
$LIND/mx null create=tc30issn count=0
$LIND/mx tc30scielo append=tc30issn -all now
$LIND/mx seq=tc30add.seq append=tc30issn "proc='d*a30~'v1'~a222~'v2'~a22~'v3'~'" -all now
$LIND/mx wtrig_titles append=tc30issn -all now
$LIND/mx tc30issn "fst=@../tc30issn.fst" fullinv/ansi=tc30issn tell=5000

echo "*********************************************************************************************"
echo "*****     Parte 4 -  Une as bases geradas nas partes 1 e 3 e aplica TRIGRAMA entre      *****"
echo "*****                títulos não convertidos e convertidos pela base WTRIG_TITLES,      *****"
echo "*****                possibilitando assim a correção de mais alguns títulos             *****"

echo "**                                  Gera a base WTRIG_TITLES2                              **"

$LIND/mx null count=0 create=delaa
$LIND/mx contav30 uctab=ansi append=delaa -all now "proc='a2~'v1'~'" "proc='Gsplit=2=words'" "proc=if v2='' then 'd1a1~XX~' else 'd2' fi" "proc=if size(v1)<5 then 'd*a2~'v1'~' else 'd1a1~'v1'~a2~'ref(['tc30issn']l(['tc30issn']mpu,v1,mpl),mpu,v222^a,mpl)'~' fi" "proc=if v2='' then 'd*a1~'v1'~' else 'd*' fi"

$LIND/mx null count=0 create=delbb
$LIND/mx tc30issn -all now append=delbb "proc=if p(v400) and  p(v222) then 'd*a100~'v100'~a150~'v150'~a151~'v151'~' else, if a(v400) and p(v222) then 'd*a150~'v30'~a151~'v2'~' else if a(v222) then 'd*' fi, fi, fi" "proc=if v150=v151 or v151='' or size(v151)<5 then 'd151' fi,if size(v150)<5 then 'd150' fi,if size(v100)<5 then 'd100' fi"

$LIND/mx delbb -all now iso=delbb.iso
$LIND/mx delaa -all now iso=delaa.iso
$LINDFFI/mx iso=delaa.iso -all now create=delaaffi
$LINDFFI/mx iso=delbb.iso -all now create=delbbffi
rm del??.iso

echo "**   Aplica trigramas entre títulos não convertidos e convertidos pela base WTRIG_TITLES   **"

$LIND/wtrig1 documents=delbbffi case=ansi "extract=v100/v150/v151/" dmfn bin tell=10000
$LIND/wtrig1 documents=delaaffi case=ansi "extract=if p(v1) then v1/  else 'falta' fi" dmfn bin tell=10000
$LIND/wtrig2 documents=delaaffi collection=delbbffi loadvectors loadindex cmfn=1 minsim=0.8 tell=15000
rm del??ffi.mst del??ffi.xrf

$LINDFFI/mx delaaffi.y "proc='a333~'mfn'~'" -all now iso=aabbffi.iso
$LIND/mx null count=0 create=aabb
$LIND/mx iso=aabbffi.iso "proc='='v333" -all now append=aabb
rm aabbffi.iso

$LIND/mx null count=0 create=wtrig_titles2
$LIND/mx aabb  -all now append=wtrig_titles2 uctab=ansi "proc='d*a30~'ref(['delaa']val(v333),v1)'~a2~'ref(['delbb']val(v6[1]^*),v150)'~a5~'v6[1]^s'~'" "proc='a222~^a'ref(['tc30issn']l(['tc30issn']v2),v222^a)'~'" "proc=e1:=l(['/bases/estat/jcr/title']v222^a), if e1>0 then 'a22~'ref(['/bases/estat/jcr/title']l(['/bases/estat/jcr/title']mpu,v222^a,mpl),v400)'~' else 'a22~'ref(['tc30issn']l(['tc30issn']v2),if v22^a>'' then v22^a else v22 fi)'~' fi"
rm del* aabb*

echo "*********************************************************************************************"
echo "*******  Parte 5 - Gera base TC30ISSN, utilizando as bases geradas nas partes 1, 3 e 4 ******"
echo "**   Gera início da base TAB30ISSN, utilizando os dados da TITLE SciELO                    **"
$LIND/mx null create=tc30issn2 count=0
$LIND/mx tc30scielo append=tc30issn2 -all now
$LIND/mx seq=tc30add.seq append=tc30issn2 "proc='d*a30~'v1'~a222~'v2'~a22~'v3'~'" -all now
echo "**                         Apenda base WTRIG_TITLES2, gerada acima                         **"
$LIND/mx wtrig_titles2 append=tc30issn2 -all now

echo "**                               Apenda a base WTRIG_TITLES                                **"
$LIND/mx wtrig_titles append=tc30issn2 -all now

$LIND/mx tc30issn2 create=tc30issn1 -all now "proc=if v222='' then e1:=l(['tc30scielo']v2),if e1>0 then 'd222d22d400a222~'ref(['tc30scielo']e1,v222)'~a22~'ref(['tc30scielo']e1,v400)'~' fi, fi" "proc=if v222>'' then e1:=l(['tc30scielo']v22), e2:=l(['tc30scielo']v22^a), if e1>0 and v222^a<>ref(['tc30scielo']e1,v222^a) then 'd222a222~'ref(['tc30scielo']e1,v222)'~' else if e2>0 and v222^a<>ref(['tc30scielo']e2,v222^a) then 'd222a222~'ref(['tc30scielo']e2,v222)'~' fi, fi, fi"

$LIND/mx null create=tc30issn count=0
$LIND/mx tc30issn1 "proc=if v222^a='' then 'd*' fi" append=tc30issn -all now
$LIND/mx tc30issn1 "proc=if v222^a<>'' then 'd*' fi" append=tc30issn -all now
$LIND/mx tc30issn "fst=@../tc30issn.fst" fullinv/ansi=tc30issn tell=5000

echo "*********************************************************************************************"
echo "***********  Parte 6 - Acrescenta dados provenientes da base TC30ISSN do SciELO BR  **********"
echo "********** Gera base TC30ISSN, utilizando as bases geradas nas partes 1, 3, 4 e 6 ***********"
$LIND/mx null create=tc30issn11 count=0
$LIND/mx tc30issn1 "proc=if v222^a<>'' then 'd*' fi" append=tc30issn11 -all now
$LIND/mx null create=tc30issn3 count=0
$LIND/mx tc30issn11 "proc=e1:=l(['tc30issn_BR']v30),if e1>0 then 'd32001d32002d32003d32004d32005d32006a222~'ref(['tc30issn_BR']e1,v222,if p(v22) then '~a22~'v22'~' else '~' fi) fi" "proc=if v222^a='' then 'd*' fi" append=tc30issn3 -all now
$LIND/mx tc30issn11 "proc=e1:=l(['tc30issn_BR']v30),if e1>0 then 'd32001d32002d32003d32004d32005d32006a222~'ref(['tc30issn_BR']e1,v222,if p(v22) then '~a22~'v22'~' else '~' fi) fi" "proc=if v222^a<>'' then 'd*' fi" append=tc30issn3 -all now

$LIND/mx null create=tc30issn count=0
$LIND/mx tc30issn1 "proc=if v222^a='' then 'd*' fi" append=tc30issn -all now
$LIND/mx tc30issn3 append=tc30issn -all now

$LIND/mx tc30issn "fst=@../tc30issn.fst" fullinv/ansi=tc30issn tell=5000
rm tc30issn11.*
rm tc30issn3.*
rm tc30issn2.*


cp tc30issn.mst ..
cp tc30issn.xrf ..
cp tc30issn.cnt ..
cp tc30issn.iyp ..
cp tc30issn.ly1 ..
cp tc30issn.ly2 ..
cp tc30issn.n01 ..
cp tc30issn.n02 ..

unset CIPAR
echo "*********************************************************************************************"
echo "*********************************************************************************************"
echo "*****************************   !!!!!       FIM       !!!!!   *******************************"
echo "*********************************************************************************************"
echo "*********************************************************************************************"



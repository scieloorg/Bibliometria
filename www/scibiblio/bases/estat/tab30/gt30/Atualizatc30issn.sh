# -------------------------------------------------------------------------- #
# Atualizatc30issnCL.sh - Gera Tabela de Correcao do Tit Citado
# -------------------------------------------------------------------------- #
#     entrada :
#       saida :
#    corrente : ???/www/scibiblio/bases/estat/tab30/gt30
# observacoes :
# -------------------------------------------------------------------------- #
# DATA      RESP              Comantarios
# 20041022  Rogerio 		  Edicao original
#
# -------------------------------------------------------------------------- #

echo "Inicio de $0 em `date`"

export BACKDIR=`pwd`
cd ../tab30/gt30

echo "Salva copia de bases necessarias a atualizacao em diretório OLD"
if [ ! -d old ]
then
  mkdir old
fi

cp ../tc30issn.mst old
cp ../tc30issn.xrf old
cp wtrig_* old

echo "******           SHELL PARA ATUALIZAÇÃO DA BASE DE CORREÇÃO DE TÍTULOS DE REVISTAS:        ******"

. ../../SetAmbBibliometriaSciELO.txt
CIPAR=cipargt30.cip; export CIPAR

$LIND/mx $SCIELO/title/title uctab=ansi create=tc30scielo -all now "proc='d*<100 0>',mpu,v100^*,mpl,'</100>',if p(v110) then '<110 0>',mpu,v100^*' - 'v110,mpl,'</110><111 0>',mpu,v100'-'v110,mpl,'</111>' fi,'<150 0>',mpu,v150,mpl'</150>',if p(v151) then '<151 0>',mpu,v151,mpl'</151>' fi,'<222 0>^a',v100^*,'^bSCIELO</222><400 0>'v400'</400>'"
rm tc30scielo.iy0
$LIND/mx tc30scielo "fst=@tc30scielo.fst" fullinv/ansi=tc30scielo
$LIND/mkiy0 tc30scielo 
rm tc30scielo.cnt
rm tc30scielo.n0?
rm tc30scielo.ly?
rm tc30scielo.iyp
 $LIND/mx tc30scielo create=tc30issn2 -all now
 $LIND/mx seq=tc30add.seq append=tc30issn2 "proc='d*<30 0>'v1'</30><222 0>'v2'</222><22 0>'v3'</22>'" -all now
 $LIND/mx wtrig_titles2 append=tc30issn2 -all now
 $LIND/mx wtrig_titles append=tc30issn2 -all now
 
 $LIND/mx tc30issn2 create=tc30issn1 -all now "proc=if v222='' then e1:=l(['tc30scielo']v2),if e1>0 then 'd222d22d400<222 0>'ref(['tc30scielo']e1,v222)'</222><22 0>'ref(['tc30scielo']e1,v400)'</22>' fi, fi" "proc=if v222>'' then e1:=l(['tc30scielo']v22), e2:=l(['tc30scielo']v22^a), if e1>0 and v222^a<>ref(['tc30scielo']e1,v222^a) then 'd222<222 0>'ref(['tc30scielo']e1,v222)'</222>' else if e2>0 and v222^a<>ref(['tc30scielo']e2,v222^a) then 'd222<222 0>'ref(['tc30scielo']e2,v222)'</222>' fi, fi, fi" "proc=e1:=l(['tc30scielo']mpu,v222^a,mpl),if e1>0 then 'd22<22 0>'ref(['tc30scielo']e1,v400)'</22>' fi" 

$LIND/mx null create=tc30issn2 count=0
$LIND/mx tc30issn1 append=tc30issn2 -all now "proc=if v222^a='' then 'd*' fi"
$LIND/mx tc30issn1 append=tc30issn2 -all now "proc=if v222^a<>'' then 'd*' fi" 

$LIND/mx null create=tc30issn count=0
$LIND/mx tc30issn2 append=tc30issn -all now

rm tc30issn.iy0
$LIND/mx tc30issn "fst=@../tc30issn.fst" fullinv/ansi=tc30issn tell=5000
$LIND/mkiy0 tc30issn
rm tc30issn.cnt
rm tc30issn.n0?
rm tc30issn.ly?
rm tc30issn.iyp
rm tc30issn1.*
rm tc30issn2.*

echo "Move para path correto"

mv tc30issn.mst ..
mv tc30issn.xrf ..
mv tc30issn.iy0 ..

unset CIPAR
. ../../UnsetAmbBibliometriaSciELO.txt

cd $BACKDIR
unset BACKDIR

echo "*********************************************************************************************"
echo "*****************************   !!!!!       FIM       !!!!!   *******************************"
echo "*********************************************************************************************"
echo "Termino de $0 em `date`"

# ------------------------------------------------------------------------- #
# AtualizaBibliometriaSciELO
# ------------------------------------------------------------------------- #
# Diretorio corrente: bases/estat/artigo
# Sintaxe: ./AtualizaBibliometriaSciELO.sh
# ------------------------------------------------------------------------- #
# Data      Responsavel Comentario
# 20040920  RMugnaini   Edicao original
#
  
echo "Iniciando $0 - `date`"

. ../SetAmbBibliometriaSciELO.txt

if [ ! -d old ]
then
  mkdir old
  mkdir old/xml
fi

if [ ! -d old/xml ]
then
  mkdir old/xml
fi

cp *.* old
cp $XML/*.xml old/xml

mv title.* $JCR/. 

echo "Limpa diretório run"
cp run/all*.seq run/alltitsanos.* $CGIXML
mv run/*.* .

echo "Recria pagina de navegacao para a bibliometria"
sh -x $XML/genselbox.sh

cd $ROOT/bases/iah/library
$LIND/mx iso=v677iah.iso "fst=1 1000 '/',ref(['../../artigo/artigo']l(['../../artigo/artigo']'IV=',v880,'=H'),mfn),'/',,,(if v677^p>'' then v677^p/ fi)" fullinv=v677iahp tell=10000 master=../../artigo/artigo
$LIND/mx iso=v677iah.iso "fst=2 1000 '/',ref(['../../artigo/artigo']l(['../../artigo/artigo']'IV=',v880,'=H'),mfn),'/',,,(if v677^i>'' then v677^i/ fi)" fullinv=v677iahi tell=10000 master=../../artigo/artigo
$LIND/mx iso=v677iah.iso "fst=3 1000 '/',ref(['../../artigo/artigo']l(['../../artigo/artigo']'IV=',v880,'=H'),mfn),'/',,,(if v677^e>'' then v677^e/ fi)" fullinv=v677iahe tell=10000 master=../../artigo/artigo
cd $ALLANOS

unset XML
unset CGIXML
unset JCR
unset CISIS

. ../UnsetAmbBibliometriaSciELO.txt

echo "Finalizando $0 - `date`"

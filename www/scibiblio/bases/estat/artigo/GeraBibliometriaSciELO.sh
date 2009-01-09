# ------------------------------------------------------------------------- #
#
# ------------------------------------------------------------------------- #
# Diretorio corrente : ../scibiblio/bases/esta/artigo
# Sintaxe : ./GeraBibliometriaSciELO.sh
# ------------------------------------------------------------------------- #
# Data      Responsavel  Comentarios
# 20040920  RMugnaini    Edicao Original
#
# -------------------------------------------------------------------------- #
echo "Inicio de $0 em `date`"

echo "Atualiza base de correcao de títulos citados"
sh -x ../tab30/gt30/Atualizatc30issn.sh

. ../SetAmbBibliometriaSciELO.txt

# Inverte a Title segundo a FST em JCR
echo "Inverte title..."
cp $SCIELO/title/title.mst .
cp $SCIELO/title/title.xrf .

rm title.iy0
$LIND/mx title fst=@$JCR/title.fst fullinv/ansi=title tell=40
$LIND/mkiy0 title
rm title.cnt
rm title.n0?
rm title.ly?
rm title.iyp

echo "Inverte Artigo por diversos criterios"
echo "  por TP"
rm run/artigo.iy0
$LIND/mx $SCIELO/artigo/artigo fst=@artigo-cr.fst fullinv/ansi=run/artigo tell=50000
$LIND/mkiy0 run/artigo
rm run/artigo.cnt
rm run/artigo.n0?
rm run/artigo.ly?
rm run/artigo.iyp

echo "  filtra TP=C"
rm run/artigoc.iy0
$LIND/mx cipar=artigo.cip artigo "bool=tp=c" fst=@artigoc.fst fullinv/ansi=run/artigoc tell=10000
$LIND/mkiy0 run/artigoc
rm run/artigoc.cnt
rm run/artigoc.n0?
rm run/artigoc.ly?
rm run/artigoc.iyp
echo "  filtra TP=H"
rm run/artigoh.iy0
$LIND/mx cipar=artigo.cip artigo "bool=tp=h" fst=@artigoh.fst fullinv/ansi=run/artigoh tell=5000
$LIND/mkiy0 run/artigoh
rm run/artigoh.cnt
rm run/artigoh.n0?
rm run/artigoh.ly?
rm run/artigoh.iyp
echo "  filtra TP=I"
rm run/artigoi.iy0
$LIND/mx cipar=artigo.cip artigo "bool=tp=i" fst=@artigoi.fst fullinv/ansi=run/artigoi tell=1000
$LIND/mkiy0 run/artigoi
rm run/artigoi.cnt
rm run/artigoi.n0?
rm run/artigoi.ly?
rm run/artigoi.iyp

echo "Gera bases pre-tabuladas por anos, para citacoes recebidas e concedidas"
sh -x artigo-cit_TB.sh

echo "Processa Co-autoria PAIS-PAIS"
sh -x $COAUT/genco-autor.sh

echo "Gera bases com: revistas; anos; países de artigos de SciELO"
sh -x all_rev_ano_pais.sh

. ../UnsetAmbBibliometriaSciELO.txt

echo "Termino de $0 em `date`"

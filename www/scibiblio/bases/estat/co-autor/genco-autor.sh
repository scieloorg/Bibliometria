# ------------------------------------------------------------------------------------- #
# genco-autor.sh - Gera base para bibliometria e arquivo invertido para o IAH do SciELO
# ------------------------------------------------------------------------------------- #

  cd $SCIELO

echo "Padroniza PAIS de afiliacao"
./tphaf.sh

  cd $COAUT

echo "Gera indice de Co-autoria PAIS-PAIS"
./v677.sh

  cd $ALLANOS


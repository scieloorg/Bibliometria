# ------------------------------------------------------------------------- #
# genselbox.sh - Gera Select Box XML das paginas estaticas da bibliometria
# ------------------------------------------------------------------------- #

cd $XML

$LIND/mx cipar=ciparhtdocs.cip title create=tit_ansi -all now uctab=ansi "proc='d*','<111 0>'mpu,v100,mpl'</111>',|<100 0>|v100|</100>|,|<400 0>|v400|</400>|,|<68 0>|v68|</68>|"
$LIND/msrt tit_ansi 30 v111

$LIND/mx $ALLANOS/allanos create=allanos -all now
$LIND/msrt allanos 5 v1^s

$LIND/mx null create=allpais count=0
$LIND/mx $ALLANOS/all_pais uctab=ansi "proc=if v1^*='-' or v1^*='BR' then 'd*' else 'd1a1~', v1, ref(['$COAUT/3166']l(['$COAUT/3166']v1^*),'^p',v1,'^i',v2,'^e',v3), '~' fi" append=allpais -all now
$LIND/msrt allpais 60 v1^u

echo " 1 - Geracao de pags web para Bibliometria SciELO"

# Gera a pag - Lista de Ferramentas
$XML/02.sh

# Gera a pag - Lista de Dados Fonte
$XML/03.sh

# Gera a pag - Fator de Impacto 2 Anos
$XML/04.sh

# Gera a pag - Fator de Impacto 3 Anos
$XML/18.sh

# Gera a pag - Vida Media
$XML/07.sh

# Gera a pag - Citacoes Recebidas
$XML/09.sh

# Gera a pag - Citacoes Concedidas
$XML/11.sh

# Gera a pag - Co-autoria
$XML/16.sh

cd -

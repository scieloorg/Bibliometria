# all_rev_ano - Gera dados de revista e ano para select box da pag de acesso
# -------------------------------------------------------------------------- #
#     Entrada:
#       Saida:
#    Corrente: ???/www/scibiblio/bases/estat/artigo
# Observacoes:
# -------------------------------------------------------------------------- #
# DATA      RESP             Comentario
# 20040920  Rogerio          Edicao original

export CIPAR=./artigoh.cip

echo "Iniciando execucao de $0"

# -------------------------------------------------------------------------- #
# Criando base alltitsanos, com todos os títulos e anos de SciELO Cuba

echo "Criando base alltitsanos, com todos os títulos e anos de SciELO"
$LIND/mxtb artigoh create=run/issns_anos "bool=$" "17:'^i',v880*1.9, '^a',v880*10.4" class=100000

$LIND/mx run/issns_anos create=run/alltitsanos uctab=ansi "proc='d*a2~', v1, '^t', ref(['title']l(['title']v1^i),mpu,v100,mpl), '~'" -all now

$LIND/msrt run/alltitsanos 150 v2^t,v2^a

# -------------------------------------------------------------------------- #
# Cria allanos.seq, com todos os anos de SciELO

echo "Cria allanos.seq"
$LIND/mxtb artigoh create=run/allanos "bool=$" "13:'^a',v880*10.4,'^s',f(99999-val(v880*10.4),1,0)" class=100000

$LIND/msrt run/allanos 10 v1^a
$LIND/mx run/allanos "pft=if mfn=1 then 'a|'v1^a|;| else v1^a|;| fi" -all now>run/allanos.seq

# -------------------------------------------------------------------------- #
# Cria alltits.seq, com todos os títulos de SciELO

echo "Cria alltits.seq"
$LIND/mxtbansi artigoh create=run/alltits uctab=ansi "bool=$" "200:'^i',v880*1.9,'^t', ref(['title']l(['title']v880*1.9),mpu,v100,mpl)" class=100000
$LIND/msrt run/alltits 200 v1^t
$LIND/mx run/alltits lw=999 "pft='t|'v1/" -all now>run/alltits.seq

# -------------------------------------------------------------------------- #
#Cria allpais.seq, com todos os países de afiliação de autores em SciELO

echo "Cria allpais.seq"
$LIND/mxtbansi ../../../../bases/afp/org710 create=run/all_pais uctab=ansi "100:proc(('a617~^p'if v710^0*1<>'' then v710^0*1 else, if v710^0:'-' then '-' else '-' fi,fi'~')),(if v617^p<>'' then v617^p'^u'ref(['../co-autor/3166']l(['../co-autor/3166']v617^p),mpu,v3,mpl)/ fi)" class=100000

$LIND/msrt run/all_pais 100 v1^u

$LIND/mx run/all_pais "pft=if mfn=1 then 'p|1'/ fi,'p|',v1^*/" lw=999 -all now>run/allpais.seq

# -------------------------------------------------------------------------- #
unset CIPAR
echo "Termino de execucao de ALL_REV_ANO_PAIS"



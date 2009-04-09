# ------------------------------------------------------------------------- #
# genselbox.sh - Gera Select Box XML das paginas estaticas da bibliometria
# ------------------------------------------------------------------------- #

cd xml

mx ../run/allanos create=allanos -all now
msrt allanos 5 v1^s

mx null create=allpais count=0
mx ../run/all_pais uctab=ansi "proc=if v1^*='-' or v1^*='BR' then 'd*' else 'd1a1~', v1, ref(['../../co-autor/3166']l(['../../co-autor/3166']v1^*),'^p',v1,'^i',v2,'^e',v3), '~' fi" append=allpais -all now
msrt allpais 60 v1^u

echo " 1 - Geracao de pags web para Bibliometria SciELO"

# Gera a pag - Lista de Ferramentas
\. 02.sh

# Gera a pag - Lista de Dados Fonte
\. 03.sh

# Gera a pag - Fator de Impacto 2 Anos
\. 04.sh

# Gera a pag - Fator de Impacto 3 Anos
\. 18.sh

# Gera a pag - Vida Media
\. 07.sh

# Gera a pag - Citacoes Recebidas
\. 09.sh

# Gera a pag - Citacoes Concedidas
\. 11.sh

# Gera a pag - Co-autoria
\. 16.sh

cd -


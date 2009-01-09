mxtbansi issn2004 create=issnv222TB minfreq=2 "200:v222^a" class=3000000 tell=100000 &
msrt issnv222TB 10 v998
mx issnv222TB "fst=1 0 v1" fullinv=issnv222TB tell=100000

# mx issnv222TBclean "join=issnv222TB=v1" "pft=if v32001^m='' then mfn/ fi" now
# mx issnv222TBclean "join=issnv222TB=v1" "pft=if v999[1]<>v999[2] then mfn/ fi" now to=100


/utl/lind/mx seq=clean_titles.seq create=clean_titles -all now
/utl/lind/mx clean_titles iso=clean_titles.iso -all now
/utl/lindffi/mx iso=clean_titles.iso create=clean_titlesffi -all now
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Tabulei títulos (v222^a) limpos para fazer Join com 
## a base de variantes (V155.60, gerado por "clean_titles.in")
mxtbansi issn2004 create=issnv222TBclean "60:proc('d*<10 0>'mpu,v222^a,mpl'</10>'),proc('Gclean_titles'),proc('Gclean_titles'),proc('Gclean_titles'),proc('Gclean_titles'),proc('Gclean_titles'),proc('Gsplit/clean=10'),v10/" class=3000000 tell=100000
msrt issnv222TBclean 10 v998
"Cria campo V155, com 60 caracteres MAX, que reune os varios títulos, limpos
" V10 é o V222^A, limpo, para join com a base "issnv222TBclean"
mx issn2004 in=clean_titles.in create=issn2004_clean -all now tell=100000
mx issn2004_clean "fst=1 0 v10[1]" fullinv=issn2004_clean tell=100000
mx issn2004 in=clean_titles.in "proc=e2:=l(['/bases/estat/jcr/fat_imp']v22),if e2>0 then proc(ref(['/bases/estat/jcr/fat_imp']e2,'<221 0>'v1'</221><223 0>'v3.60'</223>')),e1:=0,(if v221[1]=v155 then e1:=e1+1 fi),if e1>0 then 'd221' else 'd221<155 0>',v221[1],'</155>' fi,e3:=0,(if v223[1]=v155 then e3:=e3+1 fi),if e3>0 then 'd223' else 'd223<155 0>',v223[1],'</155>' fi, fi" "fst=1 0 (v10/)(v155/)" fullinv=issn2004_clean_155 tell=100000
mx issnv222TBclean "join=issn2004_clean,155=v1" "proc='d32001'" jmax=150 "fst=1 0 (v1/)(v155/)" fullinv=issn2004_clean_277TB155 tell=50000

-------------------------
#Para testar a eficiencia dos campos V155, aplico na CONTAV30
#1-Só cria V11 quando HIT é único
mx cipar=/bases/issn2004/clean_titles.cip /bases/estat/tab30/gt30/contav30 "proc=proc('<100 0>'v1'</100>'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('Gsplit/clean=100')," "proc=if npost(['issn2004_clean_155']v100)=1 then '<11 0>'ref(['issn2004_clean_155']l(['issn2004_clean_155']v100),v10[1])'</11>' fi"
#2-Cria V11 sempre
mx cipar=/bases/issn2004/clean_titles.cip /bases/estat/tab30/gt30/contav30 "proc=proc('<100 0>'v1'</100>'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('G/bases/issn2004/clean_titles'),proc('Gsplit/clean=100')," "proc='<11 0>'ref(['issn2004_clean_155']l(['issn2004_clean_155']v100),v10[1])'</11>'"

##-------Checagem do conteúdo dos campos--------
## Verificar "perigo" do V245^a, dada a grande concentração de 
##  "REPORT" para diferentes titulos (MFNs= 331131 422425 518434 607166)
mxtbansi issn2004 create=issnv245TB minfreq=30 "200:mpu,v245^a" class=3000000 tell=100000
msrt issnv245TB 10 v998
## --- Soh para Brasil
mxtbansi issn2004 create=issnv245TBbr minfreq=3 "200:if v8*15.2='br' then mpu,v245^a fi" class=3000000 tell=100000
msrt issnv245TBbr 10 v998
## Mas o perigo mesmo é quando só tem subcampo A
mxtbansi issn2004 create=issnv245^A_TB minfreq=3 "200:if v245^u='' and v245^s='' then mpu,v245^a fi" class=3000000 tell=100000
msrt issnv245^A_TB 10 v998
# Equando os subcampos S e U estao presentes...
mxtbansi issn2004 create=issnv245^SU_TB minfreq=3 "200:if v245^u<>'' and v245^s<>'' then mpu,v245^a fi" class=3000000 tell=100000
msrt issnv245^SU_TB 10 v998
# Parece que eh melhor nao utilizar V245: ver TXT gerado abaixo
mx issnv245TB "pft=v999,c15,v1/" now count=45>issnv245TB_top45.txt
mx issnv245TBbr "pft=v999,c15,v1/" now count=45>issnv245TBbr_top45.txt
mx issnv245^A_TB "pft=v999,c15,v1/" now count=45>issnv245^A_TB_top54.txt
mx issnv245^SU_TB "pft=v999,c15,v1/" now count=45>issnv245^SU_TB_top54.txt


#------------------------------------------------------------------------------------------------
echo "Tabula PUBLICACAO SciELO, ANUALMENTE - nao importa o tipo de documento"

echo "Contar Titulos, Fasciculos e artigos, segundo data de PUBLICACAO - ano e mes"

echo "Conta titulos"

$LIND/mxtb run/artigonp create=run/estat_publica_tit "bool=TP=I" "13:v35,v65.4" tell=20000 class=500000
$LIND/msrt run/estat_publica_tit 4 v1*9
$LIND/mxtb run/estat_publica_tit create=run/estat_publica_titTB "4:v1*9" class=100000
$LIND/msrt run/estat_publica_titTB 4 v1

echo "Conta fasciculos"

$LIND/mxtb run/artigonp create=run/estat_publica_fasc "bool=TP=H" "18:v880.14,v880*14.4" tell=20000 class=500000
$LIND/msrt run/estat_publica_fasc 4 v1*10.4
$LIND/mxtb run/estat_publica_fasc create=run/estat_publica_fascTB "4:v1*10" class=100000
$LIND/msrt run/estat_publica_fascTB 4 v1
$LIND/mx run/estat_publica_fascTB "fst=1 0 v1" fullinv=run/estat_publica_fascTB tell=50

echo "Conta artigos"

$LIND/mxtb run/artigonp create=run/estat_publica_art "bool=TP=H" "23:v880.23" tell=20000 class=500000
$LIND/msrt run/estat_publica_art 4 v1*10.4
$LIND/mxtb run/estat_publica_art create=run/estat_publica_artTB "4:v1*10" class=100000
$LIND/msrt run/estat_publica_artTB 4 v1
$LIND/mx run/estat_publica_artTB "fst=1 0 v1" fullinv=run/estat_publica_artTB tell=50

echo "Conta artigos bibliometria - neste caso importa o tipo de documento - a(v123)"

$LIND/mxtb run/artigonp create=run/estat_publica_artBib "bool=TP=H" "23:if a(v123) then v880.23 fi" tell=20000 class=500000
$LIND/msrt run/estat_publica_artBib 4 v1*10.4
$LIND/mxtb run/estat_publica_artBib create=run/estat_publica_artBibTB "4:v1*10" class=100000
$LIND/msrt run/estat_publica_artBibTB 4 v1
$LIND/mx run/estat_publica_artBibTB "fst=1 0 v1" fullinv=run/estat_publica_artBibTB tell=50

$LIND/mx run/estat_publica_titTB "join=run/estat_publica_fascTB,888:999=v1" "join=run/estat_publica_artTB,777:999=v1" "join=run/estat_publica_artBibTB,666:999=v1" "pft=if mfn=1 then 'Ano	# Tit.	# Fasc.	# Art.	# Art. Bibliomet.' fi/,v1.4,'	',v999,'	',v888,'	',v777,'	',v666/" lw=999 now>run/yr_estat_publica.xls

rm run/estat_publica_*

#------------------------------------------------------------------------------------------------
echo "Tabula MARCACAO SciELO, ANUALMENTE - nao importa o tipo de documento"

echo "Contar Titulos, Fasciculos e artigos, segundo data de MARCACAO - ano e mes"

echo "Conta titulos"

$LIND/mxtb run/artigonp create=run/estat_marca_tit "bool=TP=O" "13:v880*1.9,v91.4" tell=20000 class=500000
$LIND/msrt run/estat_marca_tit 4 v1*9
$LIND/mxtb run/estat_marca_tit create=run/estat_marca_titTB "4:v1*9" class=100000
$LIND/msrt run/estat_marca_titTB 4 v1

echo "Conta fasciculos"

$LIND/mxtb run/artigonp create=run/estat_marca_fasc "bool=TP=O" "18:v880.10,v91.4,v880*14.4" tell=20000 class=500000
$LIND/msrt run/estat_marca_fasc 4 v1*10.4
$LIND/mxtb run/estat_marca_fasc create=run/estat_marca_fascTB "4:v1*10" class=100000
$LIND/msrt run/estat_marca_fascTB 4 v1
$LIND/mx run/estat_marca_fascTB "fst=1 0 v1" fullinv=run/estat_marca_fascTB tell=50

echo "Conta artigos"

$LIND/mxtb run/artigonp create=run/estat_marca_art "bool=TP=O" "23:v880.10,v91.4,v880*14.9" tell=20000 class=500000
$LIND/msrt run/estat_marca_art 4 v1*10.4
$LIND/mxtb run/estat_marca_art create=run/estat_marca_artTB "4:v1*10" class=100000 tab=v999
$LIND/msrt run/estat_marca_artTB 4 v1
$LIND/mx run/estat_marca_artTB "fst=1 0 v1" fullinv=run/estat_marca_artTB tell=50


$LIND/mx run/estat_marca_titTB "join=run/estat_marca_fascTB,888:999=v1" "join=run/estat_marca_artTB,777:999=v1" "pft=if mfn=1 then 'Ano	# Tit.	# Fasc.	# Art.' fi/,v1.4,'	',v999,'	',v888,'	',v777/" lw=999 now>run/yr_estat_marca.xls

rm run/estat_marca_*

#------------------------------------------------------------------------------------------------
echo "Tabula MARCACAO SciELO, MENSALMENTE - nao importa o tipo de documento"

echo "Conta titulos"

$LIND/mxtb run/artigonp create=run/estat_marcaMES_tit "bool=TP=O" "15:v880*1.9,v91.6" tell=20000 class=500000
$LIND/msrt run/estat_marcaMES_tit 6 v1*9
$LIND/mxtb run/estat_marcaMES_tit create=run/estat_marcaMES_titTB "6:v1*9" class=100000
$LIND/msrt run/estat_marcaMES_titTB 6 v1

echo "Conta fasciculos"

$LIND/mxtb run/artigonp create=run/estat_marcaMES_fasc "bool=TP=O" "20:v880.10,v91.6,v880*14.4" tell=20000 class=500000
$LIND/msrt run/estat_marcaMES_fasc 6 v1*10.6
$LIND/mxtb run/estat_marcaMES_fasc create=run/estat_marcaMES_fascTB "6:v1*10" class=100000
$LIND/msrt run/estat_marcaMES_fascTB 6 v1
$LIND/mx run/estat_marcaMES_fascTB "fst=1 0 v1" fullinv=run/estat_marcaMES_fascTB tell=50

echo "Conta artigos"

$LIND/mxtb run/artigonp create=run/estat_marcaMES_art "bool=TP=O" "21:v880.10,v91.6,v880*18.5" tell=20000 class=500000
$LIND/msrt run/estat_marcaMES_art 6 v1*10.6
$LIND/mxtb run/estat_marcaMES_art create=run/estat_marcaMES_artTB "6:v1*10" class=100000 tab=v999
$LIND/msrt run/estat_marcaMES_artTB 6 v1
$LIND/mx run/estat_marcaMES_artTB "fst=1 0 v1" fullinv=run/estat_marcaMES_artTB tell=50

$LIND/mx run/estat_marcaMES_titTB "join=run/estat_marcaMES_fascTB,888:999=v1" "join=run/estat_marcaMES_artTB,777:999=v1" "pft=if mfn=1 then 'Ano	Mes	# Tit.	# Fasc.	# Art.' fi/,v1.4,'	',v1*4.2,'	',v999,'	',v888,'	',v777/" lw=999 now>run/yr_estat_marcaMES.xls

rm run/estat_marcaMES_*

#-----------------------------------------------------------------------------------------------tat_marcaMES_
echo "Tabula ADESAO SciELO, ANUALMENTE - nao importa o tipo de documento"

echo "Contar Titulos, Fasciculos e artigos, segundo data de ADESAO - ano e mes"

echo "Conta titulos"

$LIND/mxtb run/artigonp create=run/estat_adesao_tit "bool=TP=I" "13:v35,ref(['../jcr/title']l(['../jcr/title']v35),v940.4)" tell=20000 class=500000
$LIND/msrt run/estat_adesao_tit 4 v1*9
$LIND/mxtb run/estat_adesao_tit create=run/estat_adesao_titTB "4:v1*9" class=100000
$LIND/msrt run/estat_adesao_titTB 4 v1

echo "Conta fasciculos"

$LIND/mxtb run/artigonp create=run/estat_adesao_fasc "bool=TP=H" "18:v880.10,ref(['../jcr/title']l(['../jcr/title']v880*1.9),v940.4),v880*14.4" tell=20000 class=500000
$LIND/msrt run/estat_adesao_fasc 4 v1*10.4
$LIND/mxtb run/estat_adesao_fasc create=run/estat_adesao_fascTB "4:v1*10" class=100000
$LIND/msrt run/estat_adesao_fascTB 4 v1
$LIND/mx run/estat_adesao_fascTB "fst=1 0 v1" fullinv=run/estat_adesao_fascTB tell=50

echo "Conta artigos"

$LIND/mxtb run/artigonp create=run/estat_adesao_art "bool=TP=H" "23:v880.10,ref(['../jcr/title']l(['../jcr/title']v880*1.9),v940.4),v880*14.9" tell=20000 class=500000
$LIND/msrt run/estat_adesao_art 4 v1*10.4
$LIND/mxtb run/estat_adesao_art create=run/estat_adesao_artTB "4:v1*10" class=100000
$LIND/msrt run/estat_adesao_artTB 4 v1
$LIND/mx run/estat_adesao_artTB "fst=1 0 v1" fullinv=run/estat_adesao_artTB tell=50

echo "Conta artigos bibliometria - neste caso importa o tipo de documento - a(v123)"

$LIND/mxtb run/artigonp create=run/estat_adesao_artBib "bool=TP=H" "23:if a(v123) then v880.10,ref(['../jcr/title']l(['../jcr/title']v880*1.9),v940.4),v880*14.9 fi" tell=20000 class=500000
$LIND/msrt run/estat_adesao_artBib 4 v1*10.4
$LIND/mxtb run/estat_adesao_artBib create=run/estat_adesao_artBibTB "4:v1*10" class=100000
$LIND/msrt run/estat_adesao_artBibTB 4 v1
$LIND/mx run/estat_adesao_artBibTB "fst=1 0 v1" fullinv=run/estat_adesao_artBibTB tell=50

$LIND/mx run/estat_adesao_titTB "join=run/estat_adesao_fascTB,888:999=v1" "join=run/estat_adesao_artTB,777:999=v1" "join=run/estat_adesao_artBibTB,666:999=v1" "pft=if mfn=1 then 'Ano	# Tit.	# Fasc.	# Art.	# Art. Bibliomet.' fi/,v1.4,'	',v999,'	',v888,'	',v777,'	',v666/" lw=999 now>run/yr_estat_adesao.xls

rm run/estat_adesao_*

#------------------------------------------------------------------------------------------------
echo "Tabula IDIOMA DO ARTIGO SciELO, ANUALMENTE - nao importa o tipo de documento"

echo "SciELO BR - anual"
$LIND/mxtb run/artigonp create=run/estat_publica_lng_sort "bool=TP=H" "10:(v880[1]*10.4,'^l',mpu,v40,mpl/)" tell=20000 
$LIND/mx run/estat_publica_lng_sort create=run/estat_publica_lng -all now "proc='a888~',replace(f(9999999-val(v999),7,0),' ','0'),'~'"
$LIND/msrt run/estat_publica_lng 24 v1.4,v888
$LIND/mx run/estat_publica_lng "pft=if mfn=1 then 'Ano	Idioma	Freq.' fi/,v1^*,'	',v1^l,'	',v999/" lw=999 now>run/yr_estat_public_lng.xls

rm run/estat_publica_lng*

#echo "SciELO BR - full"
#$LIND/mxtb run/artigonp create=run/estat_publica_lng_sort "bool=TP=H" "10:(mpu,v40,mpl/)" tell=20000
#$LIND/msrt run/estat_publica_lng_sort 10 v998
#mx _idioma_baseFull "pft=v1,'|',v999/" now

#echo "SciELO CL - full"
#  AFI:/bases/lnk.000/b4c.chl>ll artigo.iso
#  -rw-rw-r--    1 cdrom    cdrom    31685733 Jul 20 10:16 artigo.iso
#  FTP para serverOFI
#mx null create=_idioma_artigoCL count=0
#mx iso=../jcr/abel/chile/artigo.iso append=_idioma_artigoCL -all now "proc=if v706<>'h' then 'd*' else 'd*a880~'v880'~a40~'v40'~' fi"
#mxtb _idioma_artigoCL create=_idioma_baseFullchile "10:(v40/)"
#msrt _idioma_baseFullchile 10 v998
#mx _idioma_baseFullchile "pft=v1,'|',v999/" now

#echo "SciELO CL - ultimos 5 anos"
#mxtb _idioma_artigoCL create=_idioma_base_anoChile "10:if val(v880*10.4)>2000 or val(v880*10.4)<2006 then (v880[1]*10.4'|'v40/) fi" 
#msrt _idioma_base_anoChile 4 v998,v1
#mx _idioma_base_anoChile "pft=v1,'|',v999/" now




# base (total cits artigos)			#tabs 27/07/06  conteudos tabulados 
#					  1.002.328

# 1ª tabulação de anos para uso em Citacoes concedidas e recebidas)
# 2ª tabulação de anos para uso em Citacoes concedidas)
# 3ª tabulação de anos para uso em Citacoes recebidas)

# cit_yrIng_yrEd		691.614		- define anos citante e citado, issn citante e titulocitado 
# cit_yrAll_yrEd		469.025		- total do titulo citado; define anos citante e citado 
# cit_yrIng_yrAll		 43.352		- define anos citante e citado 

# cit_allIng_yrEd		476.063		- total dos anos citante, define citado 
# cit_allAll_yrEd		216.896		- total dos anos citante, e do titulo citado; define citado 
# cit_allIng_yrAll		 21.629		- total dos anos citante, e do issn citante; define citado 

# cit_yrIng_allEd		312.131		- total dos anos citado, define citante 
# cit_yrAll_allEd		144.610		- total dos anos citado, e do titulo citado; define citante 
# cit_yrIng_allAll		 11.655		- total dos anos citado, e do issn citante; define citante 

# cit_allIng_allEd		173.642		- total dos anos citante e citado 
# cit_allAll_allEd		 64.574	- total dos anos citante e citado, e do titulo citado
# cit_allIng_allAll		  3.824		- total dos anos citante e citado, e do issn citante 

echo "---------- SELECIONA campos da base artigo"
$LIND/mx cipar=gigabase.cip null count=0 create=run/artigo-cit
$LIND/mx cipar=artigo.cip artigo "bool=tp=c" uctab=ansi append=run/artigo-cit -all now "proc=@tab301.prc" tell=250000
$LIND/mxcp run/artigo-cit  create=run/xartigo-cit clean>/dev/null
rm run/artigo-cit.*

echo "---------- TABULA bases"
$LIND/mxtbansi run/xartigo-cit create=run/cit_yrIng_yrEd "96:'^t'v400'^y'v650'^c'v330^*.60'^i'v330^i'^a'v365.4" tell=100000 class=1800000
rm run/xartigo-cit.*
$LIND/mxtbansi run/cit_yrIng_yrEd create=run/cit_yrAll_yrEd "85:'^y'v1^y'^c'v1^c'^i'v1^i'^a'v1^a" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_yrIng_yrEd create=run/cit_yrIng_yrAll "34:e1:=l(['title']v1^c.60),if e1>0 then '^t'v1^t'^y'v1^y'^i'v1^i'^a'v1^a fi" tab=v999 tell=100000 class=1800000

$LIND/mxtbansi run/cit_yrIng_yrEd create=run/cit_allIng_yrEd "90:'^t'v1^t'^c'v1^c'^i'v1^i'^a'v1^a" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_allIng_yrEd create=run/cit_allAll_yrEd "79:'^c'v1^c'^i'v1^i'^a'v1^a" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_allIng_yrEd create=run/cit_allIng_yrAll "28:e1:=l(['title']v1^c.60),if e1>0 then '^t'v1^t'^i'v1^i'^a'v1^a fi" tab=v999 tell=100000 class=1800000

$LIND/mxtbansi run/cit_yrIng_yrEd create=run/cit_yrIng_allEd "90:'^t'v1^t'^y'v1^y'^c'v1^c'^i'v1^i" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_yrIng_allEd create=run/cit_yrAll_allEd "79:'^y'v1^y'^c'v1^c'^i'v1^i" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_yrIng_allEd create=run/cit_yrIng_allAll "28:e1:=l(['title']v1^c.60),if e1>0 then '^t'v1^t'^y'v1^y'^i'v1^i fi" tab=v999 tell=100000 class=1800000

$LIND/mxtbansi run/cit_yrIng_yrEd create=run/cit_allIng_allEd "84:'^t'v1^t'^c'v1^c'^i'v1^i" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_allIng_allEd create=run/cit_allAll_allEd "73:'^c'v1^c'^i'v1^i" tab=v999 tell=100000 class=1800000
$LIND/mxtbansi run/cit_allIng_allEd create=run/cit_allIng_allAll "22:e1:=l(['title']v1^c.60),if e1>0 then '^t'v1^t'^i'v1^i fi" tab=v999 tell=100000 class=1800000

echo "---------- ORDENA"
$LIND/msrt run/cit_yrIng_yrEd 10 v998
$LIND/msrt run/cit_yrAll_yrEd 10 v998
$LIND/msrt run/cit_yrIng_yrAll 10 v998

$LIND/msrt run/cit_allIng_yrEd 10 v998
$LIND/msrt run/cit_allAll_yrEd 10 v998
$LIND/msrt run/cit_allIng_yrAll 10 v998

$LIND/msrt run/cit_yrIng_allEd 10 v998
$LIND/msrt run/cit_yrAll_allEd 10 v998
$LIND/msrt run/cit_yrIng_allAll 10 v998

$LIND/msrt run/cit_allIng_allEd 10 v998
$LIND/msrt run/cit_allAll_allEd 10 v998
$LIND/msrt run/cit_allIng_allAll 10 v998

echo "---------- INVERTE"

#run/cit_*.iy0

$LIND/mx run/cit_yrIng_yrEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_yrIng_yrEd tell=100000
$LIND/mx run/cit_yrAll_yrEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_yrAll_yrEd tell=100000
$LIND/mx run/cit_yrIng_yrAll "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_yrIng_yrAll tell=100000

$LIND/mx run/cit_allIng_yrEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_allIng_yrEd tell=100000
$LIND/mx run/cit_allAll_yrEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_allAll_yrEd tell=100000
$LIND/mx run/cit_allIng_yrAll "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_allIng_yrAll tell=100000

$LIND/mx run/cit_yrIng_allEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_yrIng_allEd tell=100000
$LIND/mx run/cit_yrAll_allEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_yrAll_allEd tell=100000
$LIND/mx run/cit_yrIng_allAll "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_yrIng_allAll tell=100000

$LIND/mx run/cit_allIng_allEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_allIng_allEd tell=100000
$LIND/mx run/cit_allAll_allEd "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_allAll_allEd tell=100000
$LIND/mx run/cit_allIng_allAll "fst=@artigo-cit_TB.fst" fullinv/ansi=run/cit_allIng_allAll tell=100000



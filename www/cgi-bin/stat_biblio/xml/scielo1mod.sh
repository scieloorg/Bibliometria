#  *** Dados Fonte ***

BEGIN

$UTL/mx BASE -all now uctab=ansi "proc='a33~'f(99999-val(v2^a),1,0)'~a5555~', ref(['$ARQ.arq']1,v5555), '~a7777~', ref(['$ARQ.arq']1,v7777),'~a7766~', ref(['$ARQ.arq']1,v7766),'~'" create=$ARQ.titsanosc

$UTL/msrt $ARQ.titsanosc 200 v2^t,v33

$UTL/mx $ARQ.titsanosc create=$ARQ.titsanosg -all now 

$UTL/mx $ARQ.titsanosc count=1 now lw=0 ISSN FORMAT1 

$UTL/mx $ARQ.titsanosc create=$ARQ.conta -all now lw=0 "proc=@scielo111.prc" "proc=@scielo112.prc" "proc='a333~LANG~'"

$UTL/mxtb $ARQ.conta create=$ARQ.issue "9:if v12<>'0' then v2^i fi" tab=v11
$UTL/mxtb $ARQ.conta create=$ARQ.artic "9:if v12<>'0' then v2^i fi" tab=v12
$UTL/mxtb $ARQ.conta create=$ARQ.citcon "9:if v12<>'0' then v2^i fi" tab=v13
$UTL/mxtb $ARQ.conta create=$ARQ.citrec "9:if v12<>'0' then v2^i fi" tab=v14

$UTL/mx $ARQ.issue "fst=1 0 v1" fullinv=$ARQ.issue
$UTL/mx $ARQ.artic "fst=1 0 v1" fullinv=$ARQ.artic
$UTL/mx $ARQ.citcon "fst=1 0 v1" fullinv=$ARQ.citcon
$UTL/mx $ARQ.citrec "fst=1 0 v1" fullinv=$ARQ.citrec

$UTL/mxtb $ARQ.issue create=$ARQ.issueTB "5:'total'" tab=v999
$UTL/mxtb $ARQ.artic create=$ARQ.articTB "5:'total'" tab=v999
$UTL/mxtb $ARQ.citcon create=$ARQ.citconTB "5:'total'" tab=v999
$UTL/mxtb $ARQ.citrec create=$ARQ.citrecTB "5:'total'" tab=v999

$UTL/mx $ARQ.conta now lw=0 "proc=@scielo121.prc" "proc=@scielo122.prc" FORMAT2

$UTL/mx $ARQ.titsanosc count=1 now lw=0 "proc='d*a5555~'v5555'~'@scielo131.prc" "proc=@scielo132.prc" FORMAT3

END


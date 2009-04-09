#  *** Dados Fonte ***

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

$UTL/mx BASE -all now uctab=ansi "proc='a33~'f(99999-val(v2^a),1,0)'~a5555~', ref(['$ARQ.arq']1,v5555), '~a7777~', ref(['$ARQ.arq']1,v7777),'~'" create=$ARQ.titsanosc

$UTL/msrt $ARQ.titsanosc 200 v2^t,v33

$UTL/mx $ARQ.titsanosc create=$ARQ.titsanosg -all now 

$UTL/mx $ARQ.titsanosc count=1 now lw=0 ISSN "pft=@$HOM/scielo1outXML1a.pft" 

$UTL/mx $ARQ.titsanosc create=$ARQ.conta -all now lw=0 "proc='<11 0>'f(npost(['arti.PAIS']v2^i'_'v2^a),1,0)'</11><12 0>'f(npost(['arth.PAIS']v2^i'_'v2^a),1,0)'</12><13 0>'f(npost(['artc.PAIS']v2^a'_'v2^i),1,0)'</13><14 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i),1,0)'</14>'" "proc=@scielo112.prc" "proc='<333 0>LANG</333><7766 0>'ref(['lst_traduc']l(['lst_traduc']'COLLECTION_'ref(['title']l(['title']v2^i),mpu,v777[1],mpl)),v1^u)'</7766>'"

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

$UTL/mx $ARQ.conta now lw=0 "proc=@scielo121.prc" "proc=@scielo122.prc" "pft=@$HOM/scielo1outXML1b.pft"

$UTL/mx $ARQ.titsanosc count=1 now lw=0 "proc='d*a5555~'v5555'~'@scielo131.prc" "proc=@scielo132.prc" "pft=@$HOM/scielo1outXML1c.pft"

echo "</root>"


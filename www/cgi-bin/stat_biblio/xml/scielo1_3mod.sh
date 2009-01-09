# **** Fator de Impacto - 3 anos ****

BEGIN

$UTL/mx null count=0 create=$ARQ.titsanosc
$UTL/mx BASE -all now append=$ARQ.titsanosc "proc=@scielo0213.prc" "proc=if val(v222)=0 then 'd*<2 0>'v2'</2><222 0>'v222'</222><33 0>'f(99999-val(v2^a),1,0)'</33>' else 'd111a33~'f(99999-val(v2^a),1,0)'~a5555~', ref(['$ARQ.arq']1,v5555), '~a7777~', ref(['$ARQ.arq']1,v7777),'~a7766~', ref(['$ARQ.arq']1,v7766),'~' fi" 
$UTL/msrt $ARQ.titsanosc 200 v33,v2^t

$UTL/mx $ARQ.titsanosc "fst=;1 0 'AA'" fullinv=$ARQ.titsanosc

$UTL/mx null count=0 create=$ARQ.titsanosg 
$UTL/mx $ARQ.titsanosc -all now append=$ARQ.titsanosg "join=$ARQ.titsanosc,505:222=if mfn=1 then 'AA' fi" "proc=if mfn=1 then 'd32001d505'proc('<401 0>'s(v505)'</401>'),proc('d401<402 0>'f(val(v401.10),1,0)'</402>') fi" "proc=if mfn=1 and val(v402)=0 then '<222 0>0</222><402 0>0</402>' else, if val(v222)=0 then 'd*' else 'd222' fi,fi"

$UTL/mx $ARQ.titsanosg "proc=@scielo0213.prc" count=1 now lw=0 ISSN FORMAT1 

$UTL/mx $ARQ.titsanosg now lw=0 "proc=@scielo0113.prc" "proc=@scielo0123.prc" "proc=@scielo0213.prc" "proc=@scielo0223.prc" "proc=@scielo031.prc" "proc='a333~LANG~'" FORMAT2 

$UTL/mx $ARQ.titsanosg count=1 now lw=0 "pft=if p(v402) and val(v402)=0 then '<table/></table_list></root>'/ else '</journal_list></table></table_list></root>'/ fi"

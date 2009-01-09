# **** Co-autoria ****

BEGIN

$UTL/mx $ARQ.paisanos -all now "proc='a33~'f(99999-val(v2^a),1,0)'~a333~LANG~a5555~', ref(['$ARQ.arq']1,v5555), '~'" create=$ARQ.paisanosc
#$UTL/msrt $ARQ.paisanosc 200 v2^p,v33

$UTL/mx null count=0 create=$ARQ.paisanost

$UTL/mx $ARQ.paisanosc append=$ARQ.paisanost "proc=if v2^a='sum' and npost(['v677']v2^c'/'v2^p,v2^t)=0 then 'd*' else, if v2^a<>'sum' and npost(['v677']v2^a,v2^c'/'v2^p,v2^t)=0 then 'd*' fi, fi" -all now

$UTL/mx $ARQ.paisanosc count=1 uctab=ansi now lw=0 "proc='a11~SHOWano~a22~SHOWpa2~'" ISSN FORMAT1

$UTL/mx $ARQ.paisanost now uctab=ansi "proc='a7777~'ref(['$ARQ.arq']1,v7777)'~a7766~'ref(['$ARQ.arq']1,v7766)'~'" lw=0 FORMAT3 

END



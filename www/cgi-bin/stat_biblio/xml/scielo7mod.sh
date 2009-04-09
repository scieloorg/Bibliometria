# **** Co-autoria ****

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

$UTL/mx $ARQ.paisanos -all now "proc='a33~'f(99999-val(v2^a),1,0)'~a333~LANG~a5555~', ref(['$ARQ.arq']1,v5555), '~'" create=$ARQ.paisanosc
#$UTL/msrt $ARQ.paisanosc 200 v2^p,v33

$UTL/mx null count=0 create=$ARQ.paisanost

$UTL/mx $ARQ.paisanosc append=$ARQ.paisanost "proc=if v2^a='sum' and npost(['v677']v2^c'/'v2^p,v2^t)=0 then 'd*' else, if v2^a<>'sum' and npost(['v677']v2^a,v2^c'/'v2^p,v2^t)=0 then 'd*' fi, fi" -all now

$UTL/mx $ARQ.paisanosc count=1 uctab=ansi now lw=0 "proc='a11~SHOWano~a22~SHOWpa2~'" ISSN "pft=@$HOM/scielo7outXML1a.pft"

$UTL/mx $ARQ.paisanost now uctab=ansi "proc='a7777~'ref(['$ARQ.arq']1,v7777)'~'" "proc='<7766 0>'ref(['lst_traduc']l(['lst_traduc']'COLLECTION_'ref(['title']l(['title']v2^i),mpu,v777[1],mpl)),v1^u)'</7766>'" lw=0 "pft=@$HOM/scielo7outXML1c.pft" 

echo "</cooperation_list></root>"



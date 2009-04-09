# **** Fator de Impacto - 3 anos ****

echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?><root>"

$UTL/mx null count=0 create=$ARQ.titsanosc
$UTL/mx BASE -all now append=$ARQ.titsanosc "proc='<111 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'v2^a),1,0)'</111><222 0>'f(npost(['arth.PAIS']v2^i'_'v2^a),1,0)'</222>'" "proc=if val(v222)=0 then 'd*<2 0>'v2'</2><222 0>'v222'</222><33 0>'f(99999-val(v2^a),1,0)'</33>' else 'd111a33~'f(99999-val(v2^a),1,0)'~a5555~', ref(['$ARQ.arq']1,v5555), '~a7777~', ref(['$ARQ.arq']1,v7777),'~' fi" 
$UTL/msrt $ARQ.titsanosc 200 v33,v2^t

$UTL/mx $ARQ.titsanosc "fst=;1 0 'AA'" fullinv=$ARQ.titsanosc

$UTL/mx null count=0 create=$ARQ.titsanosg 
$UTL/mx $ARQ.titsanosc -all now append=$ARQ.titsanosg "join=$ARQ.titsanosc,505:222=if mfn=1 then 'AA' fi" jmax=50 "proc=if mfn=1 then 'd32001d505'proc('<401 0>'s(v505)'</401>'),proc('d401<402 0>'f(val(v401.10),1,0)'</402>') fi" "proc=if mfn=1 and val(v402)=0 then '<222 0>0</222><402 0>0</402>' else, if val(v222)=0 then 'd*' else 'd222' fi,fi"

$UTL/mx $ARQ.titsanosg "proc='<111 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'v2^a),1,0)'</111><222 0>'f(npost(['arth.PAIS']v2^i'_'v2^a),1,0)'</222>'" count=1 now lw=0 ISSN "pft=@$HOM/scielo1_3outXML1a.pft" 

$UTL/mx $ARQ.titsanosg now lw=0 "proc='<4 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-1,1,0)),1,0)'</4><5 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-2,1,0)),1,0)'</5><6 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-3,1,0)),1,0)'</6><7 0>'f(npost(['arth.PAIS']v2^i'_'f(val(v2^a)-1,1,0)),1,0)'</7><8 0>'f(npost(['arth.PAIS']v2^i'_'f(val(v2^a)-2,1,0)),1,0)'</8><9 0>'f(npost(['arth.PAIS']v2^i'_'f(val(v2^a)-3,1,0)),1,0)'</9>'" "proc=@scielo0123.prc" "proc='<111 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'v2^a),1,0)'</111><222 0>'f(npost(['arth.PAIS']v2^i'_'v2^a),1,0)'</222>'" "proc=@scielo0223.prc" "proc='<10 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i),1,0)'</10><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'v2^a),1,0)'^a0</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-1,1,0)),1,0)'^a1</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-2,1,0)),1,0)'^a2</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-3,1,0)),1,0)'^a3</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-4,1,0)),1,0)'^a4</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-5,1,0)),1,0)'^a5</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-6,1,0)),1,0)'^a6</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-7,1,0)),1,0)'^a7</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-8,1,0)),1,0)'^a8</20><20 0>'f(npost(['artc.PAIS']v2^a'44_'v2^i'65_'f(val(v2^a)-9,1,0)),1,0)'></20>'" "proc='<333 0>LANG</333><7766 0>'ref(['lst_traduc']l(['lst_traduc']'COLLECTION_'ref(['title']l(['title']v2^i),mpu,v777[1],mpl)),v1^u)'</7766>'" "pft=@$HOM/scielo1_3outXML1b.pft" 

$UTL/mx $ARQ.titsanosg count=1 now lw=0 "pft=if p(v402) and val(v402)=0 then '<table/></table_list></root>'/ else '</journal_list></table></table_list></root>'/ fi"



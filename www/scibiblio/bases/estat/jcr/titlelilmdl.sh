
 mx null count=0 create=titlelilmdl

 mx iso=titlelilmdl.iso gizmo=g850na "proc='d*','<1 0>'mfn(1)'</1>',|<400 0>|v400|</400>|,if p(v100) then '<100 0>'v100,|: |v110,'</100>' fi,|<150 0>|v150|</150>|,|<180 0>|v180|</180>|,|<920 0>|v920|</920>|,|<435 0>|v435|</435>|,|<440 0>|v440|</440>|,|<450 0>|v450|</450>|" "proc=if p(v1) then |<155 0>|v100|</155>|,|<155 0>|v150|</155>|,|<155 0>|v151|</155>| fi" "proc=(if v155>'' then '<155 0 1>'replace(v155,'.','')'</155>' fi)" -all now append=titlelilmdl

 mx titlelilmdl "fst=;1 0 (v450,'_'v100[1]/);11 0 (v450,'_'v400[1]/);2 0 v400;3 0 v100;4 0 (v155/)/" fullinv/ansi=titlelilmdl tell=4000

# mx titlelilmdl "join=../tab30/tc30issn,30,2,222=v400" jmax=12 "proc='d32001d30d222','a2~'mpu,v222[1]^a,mpl'~',('a2~'v30'~')" "proc=@proc10.prc" uctab=ansi create=titlil.tab30 -all now

# mx title gizmo=gansna "proc='d*','<1 0>'mfn(1)'</1>',|<400 0>|v400|</400>|,if p(v100) then '<100 0>'v100,|: |v110,'</100>' fi,|<150 0>|v150|</150>|,|<180 0>|v180|</180>|,|<920 0>|v920|</920>|,|<435 0>|v435|</435>|,|<440 0>|v440|</440>|,|<450 0>|v450|</450>|" "proc=if p(v1) then |<155 0>|v100|</155>|,|<155 0>|v150|</155>|,|<155 0>|v151|</155>| fi" "proc=(if v155>'' then '<155 0 1>'replace(v155,'.','')'</155>' fi)" "proc='<450 0>SciELO</450>'" -all now create=titlesci
# mx titlesci gizmo=gansna "join=../tab30/tc30issn,30,2,222=v400" jmax=15 "proc='d32001d30d222','a2~'mpu,v222[1]^a,mpl'~',('a2~'v30'~')" "proc=@proc10.prc" uctab=ansi create=titsci.tab30 -all now

# mx null create=titlilsci count=0
# mx titsci.tab30 append=titlilsci -all now
# mx titlil.tab30 append=titlilsci -all now

# rm titlesci.* titsci.tab30.* titlil.tab30.*


# mx titlilsci "fst=;1 0 (v450,'_'v100[1]/);11 0 (v450,'_'v400[1]/);2 0 v400;3 0 v100;4 0 (v155/)v2/" fullinv/ansi=titlilsci tell=4000

#../aotpxa1/mx aptits "proc='d*','<1400 0>'v400'</1400>',|<1450 0>|v450|</1450>|,|<1441 0>|v441|</1441>|,|<1440 0>|v440|</1440>|,|<155 0>|v155|</155>|" "proc=e1:=l->aptitl(v400),(if e1=0 then e1:=l->aptitl(v155) else break fi),if e1=0 then 'd*' else 'Raptitl,'f(e1,1,0) fi" "proc='d1'" -all now append=aptitsl
#mx lilacs "fst=1 0 if s(mpu,v5.1,v6,mpl)='SAS' then proc('d35'),proc('gansn,30'),proc(ref(['aptitl']l(['aptitl']v30),'<35 0>'v400'</35>')),proc(if a(v35) then ref(['aptits']l(['aptits']v30),'<35 0>'v400'</35>') fi),if size(v35)=9 then v35/,v35'y'v65.4'v'v31'n'v32'p'f(val(v14^*),1,0) fi fi" -all now ln1=xln1 ln2=xln2 +fix/m tell=20000


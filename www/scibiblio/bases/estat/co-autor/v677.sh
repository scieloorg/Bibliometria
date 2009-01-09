
$LIND/mxtbansi ../../../../bases/afp/org710 create=617TB uctab=ansi "500:(mfn'^s'v880[1],'^p',if v710^0*1<>'' then v710^0*1 else, if v710^0:'-' then '-' else '-' fi, fi/)" class=100000
 $LIND/msrt 617TB 10 v1
 $LIND/mx 617TB "fst=1 0 v1^*" fullinv=617TB -all now tell=10000
 $LIND/mx ../../../../bases/afp/org710 "join=617TB,1,999=mfn" "proc='d32001d1d998d999',('a1~'v1^p'^n'v999'~')" "proc=(if nocc(v1)=1 and val(v1^n)=1 then 'a2~1~' else 'a2~'v1'~' fi)" create=617TB2 -all now
 $LIND/mx 617TB2 "proc='d310a310~'ref(['../jcr/title']l(['../jcr/title']v880*1.9),v310)'~'" "proc=(if p(v2) then s1:=(v1^*),ref(mfn,('a675~'s1'^x'v2'~')) fi)" "proc=if nocc(v1)=1 and v675^x='1' then 'a675~'v675^x'^x'v675^*'~' fi" "proc=(if v675^*=v675^x and val(v675^n)=1 then else 'a677~'v675^*'^x'v675^x'~' fi)" "proc='d2d675'" create=v677 -all now
rm 617TB*.*

rm v677.iy0
 $LIND/mx v677 "fst=@v677.fst" fullinv=v677 tell=20000
$LIND/mkiy0 v677
rm v677.cnt
rm v677.n0?
rm v677.ly?
rm v677.iyp

 $LIND/crunchmf v677 v677ffi target=same format=cisisX
 $LINDFFI/mx v677ffi uctab=ansi "proc='d677',('a677~^p'if v677^*='-' or v677^*='' then '- NAO IDENTIFICADO' else, if v677^*='1' then '- AUTOR INDIVIDUAL' else ref(['3166ffi']l(['3166ffi']v677^*),mpu,v1,mpl) fi, fi,',',x1,if v677^x='-' or v677^x='' then '- NAO IDENTIFICADO' else, if v677^x='1' then '- AUTOR INDIVIDUAL' else ref(['3166ffi']l(['3166ffi']v677^x),mpu,v1,mpl) fi, fi,'^i',if v677^*='-' or v677^*='' then '- NOT IDENTIFIED' else, if v677^*='1' then '- INDIVIDUAL AUTHOR' else ref(['3166ffi']l(['3166ffi']v677^*),mpu,v2,mpl) fi, fi,',',x1,if v677^x='-' or v677^x='' then '- NOT IDENTIFIED' else, if v677^x='1' then '- INDIVIDUAL AUTHOR' else ref(['3166ffi']l(['3166ffi']v677^x),mpu,v2,mpl) fi, fi,'^e',if v677^*='-' or v677^*='' then '- NO IDENTIFICADO' else, if v677^*='1' then '- AUTOR INDIVIDUAL' else ref(['3166ffi']l(['3166ffi']v677^*),mpu,v3,mpl) fi, fi,',',x1,if v677^x='-' or v677^x='' then '- NO IDENTIFICADO' else, if v677^x='1' then '- AUTOR INDIVIDUAL' else ref(['3166ffi']l(['3166ffi']v677^x),mpu,v3,mpl) fi, fi,'~')" create=v677iah tell=10000 -all now

rm v677ffi.*
 
 $LINDFFI/mx v677iah iso=../../../../bases/iah/library/v677iah.iso -all now


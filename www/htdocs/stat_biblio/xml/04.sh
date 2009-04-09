

cat 041.txt>04.xml

mx ../tit_ansi uctab=ansi "pft=@selboxtits_tits.pft" lw=0 now>>04.xml

cat 042.txt>>04.xml

mx allanos uctab=ansi "pft=if val(v1^a)>1996 then '<option ',if mfn=1 then 'selected=\"true\"' fi,'>'/'<label_list>'/'<label lang=\"pt\">',v1^a,'</label>'/'<label lang=\"en\">',v1^a,'</label>'/'<label lang=\"es\">',v1^a,'</label>'/'</label_list>'/'<value>',v1^a,'</value>'/'</option>'/ fi" lw=999 now>>04.xml

cat 043.txt>>04.xml

#cat 04.xml

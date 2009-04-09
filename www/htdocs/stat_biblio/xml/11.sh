

cat 111.txt>11.xml

mx ../tit_ansi uctab=ansi "pft=@selboxtits_tits.pft" lw=0 now>>11.xml

cat 112.txt>>11.xml

mx allanos uctab=ansi "pft=if val(v1^a)>1996 then '<option ',if mfn=1 then 'selected=\"true\"' fi,'>'/'<label_list>'/'<label lang=\"pt\">',v1^a,'</label>'/'<label lang=\"en\">',v1^a,'</label>'/'<label lang=\"es\">',v1^a,'</label>'/'</label_list>'/'<value>',v1^a,'</value>'/'</option>'/ fi" lw=999 now>>11.xml

cat 113.txt>>11.xml

mx allanos uctab=ansi "pft=if val(v1^a)>1996 then '<option ',if mfn=1 then 'selected=\"true\"' fi,'>'/'<label_list>'/'<label lang=\"pt\">',v1^a,'</label>'/'<label lang=\"en\">',v1^a,'</label>'/'<label lang=\"es\">',v1^a,'</label>'/'</label_list>'/'<value>',v1^a,'</value>'/'</option>'/ fi" lw=999 now>>11.xml

cat 114.txt>>11.xml

#cat 11.xml

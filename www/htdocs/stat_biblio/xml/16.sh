

cat 161.txt>16.xml

mx ../tit_ansi uctab=ansi "pft=@selboxtits_issn.pft" lw=0 now>>16.xml

cat 162.txt>>16.xml

mx allpais "pft='<option>'/'<label_list>'/'<label lang=\"pt\">', v1^p, '</label>'/'<label lang=\"en\">', v1^i, '</label>'/'<label lang=\"es\">', v1^e, '</label>'/'</label_list>'/'<value>', v1^*, '</value>'/'</option>'/" lw=999 now>>16.xml

cat 163.txt>>16.xml

mx allpais "pft='<option>'/'<label_list>'/'<label lang=\"pt\">', v1^p, '</label>'/'<label lang=\"en\">', v1^i, '</label>'/'<label lang=\"es\">', v1^e, '</label>'/'</label_list>'/'<value>', v1^*, '</value>'/'</option>'/" lw=999 now>>16.xml

cat 164.txt>>16.xml

mx allanos uctab=ansi "pft=if val(v1^a)>1996 then '<option>'/'<label_list>'/'<label lang=\"pt\">',v1^a,'</label>'/'<label lang=\"en\">',v1^a,'</label>'/'<label lang=\"es\">',v1^a,'</label>'/'</label_list>'/'<value>',v1^a,'</value>'/'</option>'/ fi" lw=999 now>>16.xml

cat 165.txt>>16.xml

#cat 16.xml







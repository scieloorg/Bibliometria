
cat $XML/161.txt>16.xml

$LIND/mx cipar=ciparhtdocs.cip tit_ansi "pft=if npost(['artigoh']v400)>0 then '<option issn=\"',v400,'\"',x1,'siglum=\"',v68,'\">'/'<label_list>'/'<label lang=\"pt\"><![CDATA[',v100,']]></label>'/'<label lang=\"en\"><![CDATA[',v100,']]></label>'/'<label lang=\"es\"><![CDATA[',v100,']]></label>'/'</label_list>'/'<value>',v400,'</value>'/'</option>'/ fi" lw=999 now>>16.xml

cat $XML/162.txt>>16.xml

$LIND/mx allpais "pft='<option>'/'<label_list>'/'<label lang=\"pt\">', v1^p, '</label>'/'<label lang=\"en\">', v1^i, '</label>'/'<label lang=\"es\">', v1^e, '</label>'/'</label_list>'/'<value>', v1^*, '</value>'/'</option>'/" lw=999 now>>16.xml

cat $XML/163.txt>>16.xml

$LIND/mx allpais "pft='<option>'/'<label_list>'/'<label lang=\"pt\">', v1^p, '</label>'/'<label lang=\"en\">', v1^i, '</label>'/'<label lang=\"es\">', v1^e, '</label>'/'</label_list>'/'<value>', v1^*, '</value>'/'</option>'/" lw=999 now>>16.xml

cat $XML/164.txt>>16.xml

$LIND/mx allanos uctab=ansi "pft=if val(v1^a)>1996 then '<option>'/'<label_list>'/'<label lang=\"pt\">',v1^a,'</label>'/'<label lang=\"en\">',v1^a,'</label>'/'<label lang=\"es\">',v1^a,'</label>'/'</label_list>'/'<value>',v1^a,'</value>'/'</option>'/ fi" lw=999 now>>16.xml

cat $XML/165.txt>>16.xml

#cat 16.xml







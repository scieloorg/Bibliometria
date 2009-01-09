
cat $XML/021.txt>02.xml

$LIND/mx cipar=ciparhtdocs.cip tit_ansi "pft=if npost(['artigoh']v400)>0 then '<option issn=\"',v400,'\"',x1,'siglum=\"',v68,'\">'/'<label_list>'/'<label lang=\"pt\"><![CDATA[',v100,']]></label>'/'<label lang=\"en\"><![CDATA[',v100,']]></label>'/'<label lang=\"es\"><![CDATA[',v100,']]></label>'/'</label_list>'/'<value><![CDATA[',mpu,v100,mpl']]></value>'/'</option>'/ fi" lw=999 now>>02.xml

echo "</option_list>">>02.xml
echo "</root>">>02.xml


#cat 02.teste

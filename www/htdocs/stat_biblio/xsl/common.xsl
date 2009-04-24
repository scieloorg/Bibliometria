<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="path_css" select="/statistics/ini/css/scielo"/>
	<xsl:variable name="path_javascript" select="/statistics/ini/javascript/functions"/>
	<xsl:variable name="path_image_logo" select="/statistics/ini/images/logo"/>
	<xsl:variable name="path_image_email" select="/statistics/ini/images/email"/>
	<xsl:variable name="path_image_revistas" select="/statistics/ini/images/revistas"/>
	<xsl:variable name="host_client" select="/statistics/ini/hosts/client"/>
	<xsl:variable name="host_server" select="/statistics/ini/hosts/server"/>
	<xsl:variable name="host_scisite" select="/statistics/ini/hosts/sci_site"/>
	<xsl:variable name="php_main" select="/statistics/ini/php/main"/>
	<xsl:variable name="max_selection" select="/statistics/ini/forms/max_selection"/>
	<xsl:variable name="root" select="//root"/>
	<xsl:variable name="country" select="/statistics/request-vars/country"/>
	<xsl:variable name="lang_aux" select="/statistics/request-vars/lang"/>
	<xsl:template name="logo">
		<xsl:param name="goTo"/>
		<xsl:choose>
			<xsl:when test="$goTo">
				<xsl:choose>
					<xsl:when test="//statistics//instance/@id='org'">
						<a href="http://{//statistics//instance/url}//php/index.php?lang={$lang}">
							<img align="bottom" border="0">
						<xsl:attribute name="src"><xsl:value-of select="concat('/img/',$lang,$path_image_logo)"/></xsl:attribute>
					</img>
						</a>

					</xsl:when>
					<xsl:otherwise>
						<a href="http://{//statistics//instance/url}/scielo.php?lng={$lang}">
							<img align="bottom" border="0">
								<xsl:attribute name="src"><xsl:value-of select="concat('http://',//statistics/instance/url,'/img/',$lang,$path_image_logo)"/></xsl:attribute>
							</img>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><!--xsl:value-of select="concat('/img/',$lang,$path_image_logo)"/-->
				<a href="http://{$host_server}/stat_biblio/index.php?lang={$lang}&amp;country={$country}">
					<img align="bottom" border="0">
						<xsl:attribute name="src"><xsl:value-of select="concat('http://',//statistics/instance/url,'/img/',$lang,$path_image_logo)"/></xsl:attribute>
					</img>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="string-length($lang_aux) >= 1">
				<xsl:value-of select="$lang_aux"/>
			</xsl:when>
			<xsl:otherwise>pt</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="state_aux" select="/statistics/request-vars/state"/>
	<xsl:variable name="state">
		<xsl:choose>
			<xsl:when test="string-length($state_aux) >= 1">
				<xsl:value-of select="$state_aux"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$root/current_state"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="server_action_aux" select="$root/form/action"/>
	<xsl:variable name="server_action">
		<xsl:choose>
			<xsl:when test="string-length($server_action_aux) >= 1">
				<xsl:value-of select="$server_action_aux"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/statistics/request-vars/server_action"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="issn">
		<xsl:apply-templates select="/statistics/request-vars/issn"/>
	</xsl:variable>
	<xsl:variable name="YNG_values">
		<xsl:apply-templates select="/statistics/request-vars/YNG"/>
	</xsl:variable>
	<xsl:variable name="CITED_values">
		<xsl:apply-templates select="/statistics/request-vars/CITED"/>
	</xsl:variable>
	<xsl:template match="YNG | CITED">
		<xsl:choose>
			<xsl:when test="var">
				<xsl:apply-templates select="var"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="var">
		<xsl:choose>
			<xsl:when test="position() = last()">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(., '|')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:variable name="textsXMLFile" select="/statistics/ini/xml/texts"/>
	<xsl:variable name="texts" select="document(concat('file://', $textsXMLFile))/texts/xml_file_list/xml_file[@state = $state]/language[@id = $lang]"/>
	<xsl:template match="/">
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="/"
		
		</xsl:comment>
		<html>
			<xsl:apply-templates select="." mode="html-head"/>
			<xsl:apply-templates select="." mode="html-body"/>
		</html>
	</xsl:template>
	<xsl:template match="*" mode="html-head">
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="*" mode="html-head"
		
		</xsl:comment>
		<head>
			<title>
				<xsl:value-of select="$root/page_title_list/page_title[@lang = $lang]"/>
			</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
			<xsl:apply-templates select="." mode="css"/>
			<xsl:apply-templates select="." mode="javascript"/>
		</head>
	</xsl:template>
	<xsl:template match="*" mode="css">
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="*" mode="css"
		
		</xsl:comment>
		<link rel="stylesheet" type="text/css">
			<xsl:attribute name="href"><xsl:value-of select="$path_css"/></xsl:attribute>
		</link>
	</xsl:template>
	<xsl:template match="*" mode="javascript">
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="*" mode="javascript"
		
		</xsl:comment>
		<script language="javascript">
            var max_selection = <xsl:value-of select="$max_selection"/>;
        </script>
		<script language="javascript">
			<xsl:attribute name="src"><xsl:value-of select="$path_javascript"/></xsl:attribute>
		</script>
	</xsl:template>
	<xsl:template name="footer">
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template name="footer"
		
		</xsl:comment>
		<p>&#160;</p>
		<hr/>
		<p align="center">
			<i>SciELO Regional</i>
			<br/>
			<!--a href="mailto:scielo@bireme.br">
				<img align="bottom" border="0">
					<xsl:attribute name="src">
						<xsl:value-of select="concat('http://',$host_scisite,'/img/',$lang,$path_image_email)" />
					</xsl:attribute>
				</img>
				<br />
				<font size="2" color="#0000A0">scielo@bireme.br</font>
			</a-->
		</p>
	</xsl:template>
	<xsl:template match="selection">
		<xsl:param name="size"/>
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="selection"
		
		</xsl:comment>
		<xsl:variable name="name">
			<xsl:value-of select="option_list/@name"/>
		</xsl:variable>
		<xsl:variable name="selection_type">
			<xsl:value-of select="option_list/@selection_type"/>
		</xsl:variable>
		<select>
			<xsl:attribute name="name"><xsl:value-of select="concat($name, '[]')"/></xsl:attribute>
			<xsl:if test="$selection_type != ''">
				<xsl:attribute name="multiple"><xsl:value-of select="$selection_type"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="size"><xsl:value-of select="$size"/></xsl:attribute>
			<xsl:apply-templates select="option_list/option"/>
		</select>
	</xsl:template>
	<xsl:template match="option">
		<xsl:variable name="value">
			<xsl:value-of select="value"/>
		</xsl:variable>
		<xsl:variable name="label">
			<xsl:value-of select="label_list/label[@lang=$lang]"/>
		</xsl:variable>
		<xsl:variable name="selected">
			<xsl:value-of select="@selected"/>
		</xsl:variable>
		<option>
			<xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
			<xsl:if test="$selected != ''">
				<xsl:attribute name="selected"><xsl:value-of select="'selected'"/></xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$label"/>
		</option>
	</xsl:template>
	<xsl:template match="link" mode="externo">
		<xsl:comment>

		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="link" mode="externo"

		</xsl:comment>
		<xsl:variable name="url">
			<xsl:apply-templates select="url" mode="externo"/>
		</xsl:variable>
		<xsl:variable name="label">
			<xsl:value-of select="label_list/label[@lang = $lang]"/>
		</xsl:variable>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="$url"/><!-- 
				<xsl:value-of select="'&amp;debug=xml'"/>
				--></xsl:attribute>
			<xsl:value-of select="$label"/>
		</a>
	</xsl:template>
	<xsl:template match="url" mode="externo">
		<xsl:variable name="port" select="port"/>
		<xsl:variable name="path" select="path"/>
		<xsl:value-of select="protocol"/>
		<xsl:value-of select="'://'"/>
		<xsl:value-of select="host"/>
		<xsl:if test="$port != ''">
			<xsl:value-of select="':'"/>
			<xsl:value-of select="$port"/>
		</xsl:if>
		<xsl:if test="$path != ''">
			<xsl:value-of select="'/'"/>
			<xsl:value-of select="$path"/>
		</xsl:if>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="script_name"/>
		<xsl:apply-templates select="param_list"/>
	</xsl:template>
	<xsl:template match="param_list">
		<xsl:value-of select="'?'"/>
		<xsl:apply-templates select="param"/>
	</xsl:template>
	<xsl:template match="param">
		<xsl:value-of select="'&amp;'"/>
		<xsl:value-of select="name"/>
		<xsl:value-of select="'='"/>
		<xsl:value-of select="value"/>
	</xsl:template>
	<xsl:template match="link" mode="popup">
		<xsl:comment>

		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="link"

		</xsl:comment>
		<xsl:variable name="url">
			<xsl:apply-templates select="url" mode="popup"/>
		</xsl:variable>
		<xsl:variable name="label">
			<xsl:value-of select="label_list/label[@lang = $lang]"/>
		</xsl:variable>
		<xsl:variable name="state">
			<xsl:value-of select="state"/>
		</xsl:variable>
		<xsl:variable name="popup_server_action">
			<xsl:value-of select="concat('/cgi-bin/',url/path,'/',url/script_name)"/>
		</xsl:variable>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="$url"/><xsl:value-of select="concat('&amp;state=',$state)"/><xsl:value-of select="concat('&amp;server_action=',$popup_server_action)"/><!-- 
				<xsl:value-of select="'&amp;debug=xml'"/>
				--></xsl:attribute>
			<xsl:attribute name="onClick">window.open(this.href,'passwrd','width=400,height=300,resizable=yes,location=yes,menubar=no,toolbar=yes,status=yes,scrollbars=yes');return false</xsl:attribute>
			<xsl:value-of select="$label"/>
		</a>
	</xsl:template>
	<xsl:template match="url" mode="popup">
		<xsl:variable name="port" select="port"/>
		<xsl:variable name="path" select="path"/>
		<xsl:value-of select="$php_main"/>
		<xsl:value-of select="'?xml='"/>
		<xsl:value-of select="protocol"/>
		<xsl:value-of select="'://'"/>
		<xsl:value-of select="host"/>
		<xsl:if test="$port != ''">
			<xsl:value-of select="':'"/>
			<xsl:value-of select="$port"/>
		</xsl:if>
		<xsl:if test="$path != ''">
			<xsl:value-of select="'/'"/>
			<xsl:value-of select="$path"/>
		</xsl:if>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="script_name"/>
		<xsl:apply-templates select="param_list"/>
	</xsl:template>
	<xsl:template match="link">
		<xsl:comment>

		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template match="link"

		</xsl:comment>
		<xsl:variable name="url">
			<xsl:apply-templates select="url"/>
		</xsl:variable>
		<xsl:variable name="label">
			<xsl:value-of select="label_list/label[@lang = $lang]"/>
		</xsl:variable>
		<xsl:variable name="state">
			<xsl:value-of select="state"/>
		</xsl:variable>
		<xsl:variable name="country">
			<xsl:value-of select="country"/>
		</xsl:variable>
		<a>
			<xsl:attribute name="href"><xsl:value-of select="$url"/><xsl:value-of select="concat('&amp;state=',$state)"/><xsl:value-of select="concat('&amp;lang=',$lang)"/><xsl:value-of select="concat('&amp;country=',$country)"/><xsl:if test="$issn != ''"><xsl:value-of select="concat('&amp;issn=',$issn)"/></xsl:if><!-- 
				<xsl:value-of select="'&amp;debug=xml'"/>
				--></xsl:attribute>
			<xsl:value-of select="$label" disable-output-escaping="no"/>
		</a>
	</xsl:template>
	<xsl:template match="url">
		<xsl:variable name="port" select="port"/>
		<xsl:variable name="path" select="path"/>
		<xsl:value-of select="$php_main"/>
		<xsl:value-of select="'?xml='"/>
		<xsl:value-of select="protocol"/>
		<xsl:value-of select="'://'"/>
		<xsl:value-of select="$host_server"/>
		<xsl:if test="$port != ''">
			<xsl:value-of select="':'"/>
			<xsl:value-of select="$port"/>
		</xsl:if>
		<xsl:if test="$path != ''">
			<xsl:value-of select="'/'"/>
			<xsl:value-of select="$path"/>
		</xsl:if>
		<xsl:value-of select="'/'"/>
		<xsl:value-of select="script_name"/>
	</xsl:template>
	<xsl:template match="url">
		<xsl:variable name="port" select="port"/>
		<xsl:variable name="path" select="path"/>
		<xsl:value-of select="$php_main"/>?</xsl:template>

	<xsl:template name="form">
		<xsl:param name="hidden_01_name"/>
		<xsl:param name="hidden_01_value"/>
		<xsl:param name="the_font_face"/>
		<xsl:param name="the_font_size"/>
		<xsl:param name="the_font_color"/>
		<xsl:param name="the_bullet"/>
		<xsl:param name="the_label"/>
		<xsl:param name="the_form_name" select="concat('form_', $state, '_', $hidden_01_value)"/>
		<xsl:param name="the_action" select="'index.php'"/>
		<xsl:comment>
	
		**** File: file:///home/scielo/www/htdocs/stat_biblio/xsl/common.xsl
		template name="form"
		
		</xsl:comment>
		<xsl:variable name="the_href">
			<xsl:value-of select="concat('javascript:void(submit_POST_METHOD(', $the_form_name, '))')"/>
		</xsl:variable>
		<form>
			<xsl:attribute name="name"><xsl:value-of select="$the_form_name"/></xsl:attribute>
			<xsl:attribute name="action"><xsl:value-of select="$the_action"/></xsl:attribute>
			<xsl:attribute name="Xmethod"><xsl:value-of select="'post'"/></xsl:attribute>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="$hidden_01_name"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$hidden_01_value"/></xsl:attribute>
			</input>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="'state'"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$state"/></xsl:attribute>
			</input>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="'server_action'"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$server_action"/></xsl:attribute>
			</input>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="'lang'"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$lang"/></xsl:attribute>
			</input>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="'YNG'"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$YNG_values"/></xsl:attribute>
			</input>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="'CITED'"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$CITED_values"/></xsl:attribute>
			</input>
			<input>
				<xsl:attribute name="type"><xsl:value-of select="'hidden'"/></xsl:attribute>
				<xsl:attribute name="name"><xsl:value-of select="'country'"/></xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="$country"/></xsl:attribute>
			</input>
			<!-- 
			<input>
				<xsl:attribute name="type">
					<xsl:value-of select="'hidden'" />
				</xsl:attribute>
				<xsl:attribute name="name">
					<xsl:value-of select="'debug'" />
				</xsl:attribute>
				<xsl:attribute name="value">
					<xsl:value-of select="'xml'" />
				</xsl:attribute>
			</input>
			-->
			<a>
				<xsl:attribute name="href"><xsl:value-of select="$the_href"/></xsl:attribute>
				<font>
					<xsl:attribute name="face"><xsl:value-of select="$the_font_face"/></xsl:attribute>
					<xsl:attribute name="size"><xsl:value-of select="$the_font_size"/></xsl:attribute>
					<xsl:attribute name="color"><xsl:value-of select="$the_font_color"/></xsl:attribute>
					<xsl:value-of select="$the_bullet"/>
				</font>
				<xsl:value-of select="concat(' ', $the_label)"/>
			</a>
		</form>
	</xsl:template>
</xsl:stylesheet>

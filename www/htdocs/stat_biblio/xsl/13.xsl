<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="xsl/common.xsl" />	

	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 13.xsl
		template match="*" mode="html-body"
		
		</xsl:comment>
		<body>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="20%">
						<p align="center">
							<a href="http://{$host_scisite}/scielo.php?lng={$lang}">
								<img align="bottom" border="0">
									<xsl:attribute name="src">
										<xsl:value-of select="concat('http://',$host_scisite,'/img/',$lang,$path_image_logo)" />
									</xsl:attribute>
								</img>
							</a>
						</p>
					</td>
					<td align="center" width="80%">
						<blockquote>
							<p align="left">
								<font size="+1" color="#000080">
									<xsl:value-of select="$root/title_list/title[@lang = $lang]" />
								</font>
							</p>
						</blockquote>
					</td>
				</tr>
				<tr>
					<td>&#160;</td>
					<td>
						<blockquote>
							<p>
								<font color="#800000">
									<xsl:value-of select="$root/subtitle_list/subtitle[@lang = $lang]" />
								</font>
							</p>
						</blockquote>
					</td>
				</tr>
				<tr>
					<td colspan="2">&#160;</td>
				</tr>
				<xsl:apply-templates select="$root/header" />
				<tr>
					<td colspan="2">&#160;</td>
				</tr>
				<xsl:apply-templates select="$root/citation_form_list" />
			</table>
			<xsl:call-template name="footer"></xsl:call-template>
		</body>
	</xsl:template>

    <xsl:template match="header">
		<xsl:comment>
	
		**** File: 13.xsl
		template match="header"
		
		</xsl:comment>
        <tr>
            <td colspan="2"><b><xsl:value-of select="title_cited"/></b></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="citation_form_list">
   		<xsl:comment>
	
		**** File: 13.xsl
		template match="citation_form_list"
		
		</xsl:comment>
        
        <tr>
            <td colspan="2">
                <table border="0" align="center" cellpadding="2" cellspacing="2" width="80%">
                    <tr>
                    <td bgcolor="#dfebeb"><small><strong><xsl:value-of select="$texts/text[find='CITACOES']/replace" /></strong></small></td>
                    <td bgcolor="#dfebeb"><small><strong><xsl:value-of select="$texts/text[find='FREQUENCIA']/replace" /></strong></small></td>
                    </tr>
                    <xsl:apply-templates select="*"/>
                </table>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="citation_form">
        <tr bgcolor="#F2F2F2" onMouseOver="this.style.backgroundColor='#DBE5EA';this.style.color='#1a1aff'" onMouseOut="this.style.backgroundColor='#F2F2F2';this.style.color='#000000'">
            <td>
                <xsl:value-of select="title_form"/>
            </td>
            <td><xsl:value-of select="frequency"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
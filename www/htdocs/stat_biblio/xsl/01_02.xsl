<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="common.xsl" />

	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 01_02.xsl
		template match="*" mode="html-body"
		
		</xsl:comment>
		<body>

			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<xsl:apply-templates select="." mode="logo_title" />
				<xsl:apply-templates select="$root/option_list" />
			</table>
			
			<xsl:call-template name="footer"></xsl:call-template>

		</body>
	</xsl:template>

    <xsl:template match="*" mode="logo_title">
        <tr>
        	<td width="20%">
        		<p align="center">
                		<xsl:call-template name="logo"/>
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
    </xsl:template>

    <xsl:template match="subtitle">
        <tr>
            <td>&#160;</td>
            <td>
                <blockquote>
                    <p>
                        <font color="#800000">
                        	<xsl:value-of select="." />
                        </font>
                    </p>
                </blockquote>
            </td>
        </tr>
    </xsl:template>

	<xsl:template match="option_list">
		<xsl:comment>
	
		**** File: 01_02.xsl
		template match="option_list"
		
		</xsl:comment>
        <xsl:apply-templates select="$root/subtitle_list/subtitle[@lang = $lang]"/>
        <tr>
        	<td width="20%">&#160;</td>
        	<td width="80%">
    			<ul>
    				<xsl:apply-templates select="option" mode="lista"/>
    			</ul>
        	</td>
        </tr>
	</xsl:template>


	<xsl:template match="option" mode="lista">
		<xsl:comment>
	
		**** File: 01_02.xsl
		template match="stat"
		
		</xsl:comment>
			<li>
				<xsl:apply-templates select="link" />
			</li>
	</xsl:template>

</xsl:stylesheet>
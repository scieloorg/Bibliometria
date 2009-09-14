<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="xsl/01_02.xsl" />
		

    <xsl:variable name="selected_option">
        <xsl:copy-of select="//option_list[@name='journal']/option[@issn=$issn]"/>
    </xsl:variable>
 
    <xsl:template match="option_list[@name='journal']"/>
    
	<xsl:template match="option_list">
		<xsl:comment>
	
		**** File: 02.xsl
		template match="option_list"
		
        </xsl:comment>
        <xsl:choose>
            <xsl:when test="$issn != ''">
                <xsl:apply-templates select="." mode="journal"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="collection"/>
            </xsl:otherwise>
        </xsl:choose>
	</xsl:template>
        
    <xsl:template match="*" mode="collection">
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
    
    <xsl:template match="*" mode="journal">
        <tr>
        	<td width="20%">&#160;</td>
        	<td width="80%">
                <blockquote>
                    <p>
                        <font class="nomodel" color="#0000A0">
                            <b><xsl:value-of select="$texts/text[find='SITE_USAGE']/replace" /></b>
                        </font>
                    </p>
                </blockquote>
                <blockquote>
                    <ul>
        		    <li>
                            <a href="http://{//statistics/instance/url}/scielolog.php?script=sci_journalstat&amp;lng=en&amp;pid={$issn}"><xsl:value-of select="$texts/text[find='JOURNAL_ACCESS']/replace" /></a>
                        </li>
                        <li>
                            <a href="http://{//statistics/instance/url}/scielolog.php?script=sci_statiss&amp;lng=en&amp;pid={$issn}"><xsl:value-of select="$texts/text[find='ISSUE_ACCESS']/replace" /></a>
                        </li>
                        <li>
                            <a href="http://{//statistics/instance/url}/scielolog.php?script=sci_statart&amp;lng=en&amp;pid={$issn}&amp;dti=20040101"><xsl:value-of select="$texts/text[find='ARTICLE_ACCESS']/replace" /></a>
                        </li>
                    </ul>
                </blockquote>
                <!--blockquote>
                    <p>
                        <font class="nomodel" color="#0000A0"><b><xsl:value-of select="$texts/text[find='CO_AUTHOR_REPORT']/replace" /></b></font>
                    </p>
                </blockquote>
                <blockquote>
                    <ul>
                        <li><a href="index.php?state=16&amp;lang={$lang}&amp;issn={$issn}"><xsl:value-of select="$texts/text[find='CO_AUTHOR']/replace" /></a></li>
                    </ul>
                </blockquote-->
                <blockquote>
                    <p>
                        <font class="nomodel" color="#0000A0"><b><xsl:value-of select="$texts/text[find='CITATION_REPORTS']/replace" /></b></font>
                    </p>
                </blockquote>
                <blockquote>                        
	        		<ul>
			        	<xsl:apply-templates select="option" mode="lista"/>
        			</ul>
                </blockquote>
    	    </td>
        </tr>
    </xsl:template>

    <xsl:template match="*" mode="logo_title">
        <tr>
        	<td width="20%">
        		<p align="center">
                     
            				<xsl:call-template name="logo">
                			<xsl:with-param name="goTo" select="'instance'"/>
                		</xsl:call-template>
                     
                </p>
        	</td>
        	<td align="center" width="80%">
        		<blockquote>
		        	<p align="left">
				        <font size="+1" color="#000080">
                            <xsl:choose>
                                <xsl:when test="$selected_option/*"><xsl:value-of select="$selected_option/option/label_list/label[@lang = $lang]" /></xsl:when>
                                <xsl:otherwise><xsl:value-of select="$root/title_list/title[@lang = $lang]" /></xsl:otherwise>
                            </xsl:choose>										
        				</font>
                        <xsl:if test="$selected_option/*">
                            <br/><font class="nomodel" color="#000080">ISSN <xsl:value-of select="$issn"/></font>
                        </xsl:if>
		        	</p>
        		</blockquote>        
        	</td>
        </tr>    
    </xsl:template> 

</xsl:stylesheet>
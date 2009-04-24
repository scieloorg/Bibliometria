<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="xsl/common.xsl"/>
	<xsl:variable name="selected_option">
		<xsl:copy-of select="//selection_list/selection[@name='journal']/option_list/option[@issn=$issn]"/>
	</xsl:variable>
	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 16.xsl
		template match="*" mode="html-body"
		
		</xsl:comment>
		<body>
			<form action="index.php" Xmethod="post">
				<xsl:attribute name="onsubmit">javascript: return validate_16(this)</xsl:attribute>
				<input type="hidden" name="state" value="{$root/form/state}"/>
				<!--input type="hidden" name="server_action" value="{substring-before(substring-after($server_action,'/cgi-bin/stat_biblio/xml/'),'.sh')}"/-->
				<input type="hidden" name="lang" value="{$lang}"/>
				<!-- 
				<input type="hidden" name="debug" value="xml" />
				-->
				<xsl:if test="$issn != ''">
					<input type="hidden" name="issn" value="{$issn}"/>
				</xsl:if>
				<xsl:apply-templates select="$selected_option/option/value" mode="cited-hidden"/>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td width="20%">
							<p align="center">
								<xsl:choose>
									<xsl:when test="$issn != ''">
										<a href="http://{$host_scisite}/scielo.php?script=sci_serial&amp;pid={$issn}&amp;lng={$lang}">
											<img align="bottom" border="0">
												<xsl:attribute name="src"><xsl:value-of select="concat('http://',$host_scisite,$path_image_revistas,$selected_option/option/@siglum,'/plogo.gif')"/></xsl:attribute>
											</img>
										</a>
									</xsl:when>
									<xsl:otherwise>
										
										<xsl:call-template name="logo">
											<xsl:with-param name="goTo" select="'instance'"/>
										</xsl:call-template>
										<!-- nao testado, nao encontrei a pagina -->
									</xsl:otherwise>
								</xsl:choose>
							</p>
						</td>
						<td align="center" width="80%">
							<blockquote>
								<p align="left">
									<font size="+1" color="#000080">
										<xsl:choose>
											<xsl:when test="$selected_option/*">
												<xsl:value-of select="$selected_option/option/label_list/label[@lang = $lang]"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$root/title_list/title[@lang = $lang]"/>
											</xsl:otherwise>
										</xsl:choose>
									</font>
									<xsl:if test="$selected_option/*">
										<br/>
										<font class="nomodel" color="#000080">ISSN <xsl:value-of select="$issn"/>
										</font>
									</xsl:if>
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
										<xsl:value-of select="$root/subtitle_list/subtitle[@lang = $lang]"/>
									</font>
								</p>
							</blockquote>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<table border="0" cellpadding="2" cellspacing="2" align="center" width="90%">
								<tr>
									<td colspan="5" align="center">
										<xsl:if test="not($selected_option/*)">
											<xsl:apply-templates select="root/selection_list/selection[@name='journal']" mode="table_cell_content"/>
										</xsl:if>&#160;
									</td>
								</tr>
								<tr>
									<td colspan="5">&#160;</td>
								</tr>
								<tr>
									<td align="right" width="32%">
										<xsl:apply-templates select="root/selection_list/selection[@name='country1']" mode="table_cell_content">
											<xsl:with-param name="align">right</xsl:with-param>
										</xsl:apply-templates>
									</td>
									<td width="1%">&#160;</td>
									<td align="center" width="34%">
										<xsl:apply-templates select="root/selection_list/selection[@name='country2']" mode="table_cell_content">
											<xsl:with-param name="align">center</xsl:with-param>
										</xsl:apply-templates>
									</td>
									<td width="1%">&#160;</td>
									<td align="left" width="32%">
										<xsl:apply-templates select="root/selection_list/selection[@name='year_source']" mode="table_cell_content">
											<xsl:with-param name="align">left</xsl:with-param>
										</xsl:apply-templates>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">&#160;</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input>
								<xsl:attribute name="type"><xsl:value-of select="'submit'"/></xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="$texts/text[find='SEND']/replace"/></xsl:attribute>
							</input>
							&#160;&#160;&#160;
							<input>
								<xsl:attribute name="type"><xsl:value-of select="'reset'"/></xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="$texts/text[find='CLEAN']/replace"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</table>
			</form>
			<form name="formMessages">
				<input type="hidden" name="js_cited_msg" value="{$texts/text[find='CITED_REQUIRED']/replace}"/>
				<input type="hidden" name="js_pais1_msg" value="{$texts/text[find='PAIS1_REQUIRED']/replace}"/>
				<input type="hidden" name="js_pais2_msg" value="{$texts/text[find='PAIS2_REQUIRED']/replace}"/>
				<input type="hidden" name="js_yng_msg" value="{$texts/text[find='YNG_REQUIRED']/replace}"/>
			</form>
			<xsl:call-template name="footer"/>
		</body>
	</xsl:template>
	<xsl:template match="selection" mode="table_cell_content">
		<xsl:param name="align">left</xsl:param>
		<p align="{$align}">
			<font color="#000080">
				<xsl:value-of select="label_list/label[@lang = $lang]"/>
			</font>
		</p>
		<xsl:apply-templates select=".">
			<xsl:with-param name="size" select="'8'"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="* | text()" mode="cited-hidden">
		<input type="hidden" name="CITED[]" value="{.}"/>
	</xsl:template>
</xsl:stylesheet>

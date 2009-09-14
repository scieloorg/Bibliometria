<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="xsl/common.xsl"/>
	<xsl:variable name="count_sci" select="normalize-space(/statistics/request-vars/COUNT_SCI)"/>
	<!--xsl:variable name="journal">
		<xsl:copy-of select="//root/journal"/>
	</xsl:variable-->
	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 10.xsl
		template match="*" mode="html-body"
		
		</xsl:comment>
		<body>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
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
									<xsl:value-of select="$root/title_list/title[@lang = $lang]"/>
								</font>
								<xsl:if test="$journal/*">
									<br/>
									<font class="nomodel" color="#000080">ISSN <xsl:value-of select="$journal/journal/issn"/>
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
					<td colspan="2">&#160;</td>
				</tr>
				<xsl:apply-templates select="$root/header"/>
				<xsl:apply-templates select="$root/totals" mode="table_title"/>
				<xsl:apply-templates select="$root/table_list"/>
			</table>
			<xsl:call-template name="footer"/>
		</body>
	</xsl:template>
	<xsl:template match="header">
		<xsl:comment>
	
		**** File: 10.xsl
		template match="header"
		
		</xsl:comment>
		<tr>
			<td colspan="2">
				<table border="0" align="center" cellpadding="2" cellspacing="2" width="40%">
					<tr width="100%" bgcolor="#dfebeb">
						<td width="35%" align="left">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='CITACOES_RECEBIDAS_EM']/replace"/>
								</strong>
							</small>
						</td>
					</tr>
					<xsl:apply-templates select="year_list[@type='source']"/>
					<tr width="100%" bgcolor="#dfebeb">
						<td width="35%" align="left">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='AS_REVISTAS']/replace"/>
								</strong>
							</small>
						</td>
					</tr>
					<xsl:if test="not(title_list/title) and normalize-space(title_list) = 'all'">
						<tr>
							<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
							<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
							<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
							<td>
								<xsl:attribute name="width">35%</xsl:attribute>
								<xsl:attribute name="nowrap">nowrap</xsl:attribute>
								<xsl:value-of select="$texts/text[find='TITLE_ALL']/replace"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:apply-templates select="title_list/title"/>
					<tr width="100%" bgcolor="#dfebeb">
						<td width="35%" align="left">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='PUBLICADAS_EM']/replace"/>
								</strong>
							</small>
						</td>
					</tr>
					<xsl:apply-templates select="year_list[@type='before']"/>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">&#160;</td>
		</tr>
	</xsl:template>
	<xsl:template match="title">
		<xsl:comment>
	
		**** File: 10.xsl
		template match="title"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
			<td>
				<xsl:attribute name="width">35%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="year_list">
		<xsl:comment>
	
		**** File: 10.xsl
		template match="year_list"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
			<td>
				<xsl:attribute name="width">35%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>
				<xsl:if test="not(year) and normalize-space(.) = 'all'">
					<xsl:value-of select="$texts/text[find='YEAR_ALL']/replace"/>
				</xsl:if>
				<xsl:apply-templates select="year"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="year">
		<xsl:comment>
	
		**** File: 10.xsl
		template match="year_list"
		
		</xsl:comment>
		<xsl:value-of select="concat(.,'&#160;&#160;')"/>
	</xsl:template>
	<xsl:template match="totals" mode="table_title">
		<tr>
			<td colspan="2">
				<table border="0" align="center" cellpadding="2" cellspacing="2" width="70%">
					<tr>
						<td>
							<font face="arial" size="2" color="#0000A0">
								<xsl:value-of select="$texts/text[find='TOTAL_DE_CITACOES_RECEBIDAS']/replace"/>:&#160;
                        		<xsl:value-of select="citing_journals_total"/>
							</font>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="table/header" mode="table_title">
		<tr>
			<td colspan="5">
				<font face="arial" size="2" color="Maroon">
					<xsl:value-of select="$texts/text[find='RECEBIDAS_POR']/replace"/>&#160;<b>
						<xsl:value-of select="title"/>
					</b>:&#160;<xsl:value-of select="sub_total"/>
				</font>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="table_list">
		<xsl:apply-templates select="table">
			<xsl:with-param name="totals" select="../totals"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="table[not(citation_list/citation/*)]"/>
	<xsl:template match="table">
		<xsl:param name="totals"/>
		<xsl:comment>
	
		**** File: 12.xsl
		template match="table"
		
		</xsl:comment>
		<tr>
			<td colspan="2">&#160;</td>
		</tr>
		<tr>
			<td colspan="2">
				<table border="0" align="center" cellpadding="2" cellspacing="2" width="70%">
					<xsl:apply-templates select="header" mode="table_title"/>
					<tr width="100%" bgcolor="#dfebeb">
						<td width="1">&#160;</td>
						<td>
							<xsl:attribute name="width">88%</xsl:attribute>
							<xsl:attribute name="align">left</xsl:attribute>
							<b>
								<xsl:value-of select="$texts/text[find='TITULO_DA_REVISTA']/replace"/>
							</b>
						</td>
						<!-- 
						<td>
							<xsl:attribute name="width">20%</xsl:attribute>
							<xsl:attribute name="align">left</xsl:attribute>
							<b>
								<xsl:value-of select="$texts/text[find='FONTE_DE_DADOS']/replace" />
							</b>
						</td>
						-->
						<td>
							<xsl:attribute name="width">12%</xsl:attribute>
							<xsl:attribute name="align">right</xsl:attribute>
							<b>
								<xsl:value-of select="$texts/text[find='CITACOES_CONCEDIDAS']/replace"/>
							</b>
						</td>
						<!--
					     ver um dia mais a frente, o servidor nao retorna o XML, o problema deve
					     ser o parametro CITED que vem com parenteses e espacos. Faca debug no
						 index.php para conseguir o xml_url que esta´ sendo passado para a
						 aplicacao servidora. 23/12/2003
						<td>
							<xsl:attribute name="width">5%</xsl:attribute>
							<xsl:attribute name="align">left</xsl:attribute>
							<b>
								<xsl:value-of select="$texts/text[find='FORMAS_CITADAS']/replace" />
							</b>
						</td>
						-->
					</tr>
					<xsl:apply-templates select="citation_list/citation"/>
					<xsl:choose>
						<xsl:when test="header">
							<xsl:apply-templates select="citation_list" mode="other">
								<xsl:with-param name="totals" select="header/sub_total"/>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="citation_list" mode="other">
								<xsl:with-param name="totals" select="$totals/citing_journals_total"/>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="citation">
		<xsl:comment>
	
		**** File: 10.xsl
		template match="citation_list"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
			<td width="1">
				<xsl:value-of select="position()"/>.&#160;</td>
			<td>
				<xsl:attribute name="title"><xsl:value-of select="$texts/text[find='TITULO_DA_REVISTA']/replace"/></xsl:attribute>
				<xsl:attribute name="width">88%</xsl:attribute>
				<xsl:attribute name="align">left</xsl:attribute>
				<xsl:choose>
					<xsl:when test="title_citing/link_list/link [@type='scielo']">
						<xsl:apply-templates select="title_citing/link_list/link [@type='scielo']" mode="externo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="title_citing/label"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<!-- 
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='FONTE_DE_DADOS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">20%</xsl:attribute>
				<xsl:attribute name="align">left</xsl:attribute>
				<xsl:value-of select="database_title_cited" />
			</td>
			-->
			<td>
				<xsl:attribute name="title"><xsl:value-of select="$texts/text[find='CITACOES_AO_TITULO']/replace"/></xsl:attribute>
				<xsl:attribute name="width">12%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="citations_to_title_cited"/>
			</td>
			<!--
			     ver um dia mais a frente, o servidor nao retorna o XML, o problema deve
			     ser o parametro CITED que vem com parenteses e espacos. Faca debug no
				 index.php para conseguir o xml_url que esta´ sendo passado para a
				 aplicacao servidora. 23/12/2003
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='FORMAS_CITADAS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">5%</xsl:attribute>
				<xsl:attribute name="align">left</xsl:attribute>
				<xsl:apply-templates select="title_cited/link_list/link [@type='iah']" mode="popup" />
			</td>
			-->
		</tr>
	</xsl:template>
	<xsl:template match="citation" mode="clone_value">
		<xsl:if test="position() &lt;= $count_sci">
			<xsl:copy-of select="citations_to_title_cited"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="citation_list" mode="other">
		<xsl:param name="totals"/>
		<xsl:variable name="cloned_values">
			<xsl:apply-templates select="citation" mode="clone_value"/>
		</xsl:variable>
		<xsl:variable name="the_sum" select="sum($cloned_values/citations_to_title_cited)"/>
		<xsl:variable name="other" select="$totals - $the_sum"/>
		<xsl:if test="$other &gt; 0">
			<tr>
				<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
				<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
				<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
				<td width="1">&#160;</td>
				<td>
					<xsl:attribute name="title"><xsl:value-of select="$texts/text[find='TITULO_DA_REVISTA']/replace"/></xsl:attribute>
					<xsl:attribute name="width">88%</xsl:attribute>
					<xsl:attribute name="align">left</xsl:attribute>
					<b>
						<xsl:value-of select="$texts/text[find='OUTROS']/replace"/>
					</b>
				</td>
				<td>
					<xsl:attribute name="title"><xsl:value-of select="$texts/text[find='CITACOES_AO_TITULO']/replace"/></xsl:attribute>
					<xsl:attribute name="width">12%</xsl:attribute>
					<xsl:attribute name="align">right</xsl:attribute>
					<b>
						<xsl:value-of select="$other"/>
					</b>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

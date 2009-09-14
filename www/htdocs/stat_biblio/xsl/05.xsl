<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="xsl/common.xsl" />	

    <!--xsl:variable name="journal">
        <xsl:copy-of select="//root/journal"/>
    </xsl:variable-->

	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 05.xsl
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
									<xsl:value-of select="$root/title_list/title[@lang = $lang]" />
								</font>
                                <xsl:if test="$journal">
                                    <br/><font class="nomodel" color="#000080">ISSN <xsl:value-of select="$journal/journal/issn"/></font>
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
									<xsl:value-of select="$root/subtitle_list/subtitle[@lang = $lang]" />
								</font>
							</p>
						</blockquote>
					</td>
				</tr>
				<tr>
					<td colspan="2">&#160;</td>
				</tr>
					<xsl:apply-templates select="$root/table_list[@stat = 'impact_factor']/table" />
			</table>
			<xsl:call-template name="footer"></xsl:call-template>
		</body>
	</xsl:template>

							
	<xsl:template match="table">
		<xsl:comment>
	
		**** File: 05.xsl
		template match="table"
		
		</xsl:comment>
		<xsl:variable name="table_title">
			<xsl:value-of select="$texts/text[find='ANO_BASE']/replace" />
			<xsl:value-of select="' '"/>
			<xsl:value-of select="@year" />
		</xsl:variable>
		<xsl:variable name="a_columm_title">
			<xsl:value-of select="$texts/text[find='CITACOES_FEITAS_EM']/replace" />
			<xsl:value-of select="' '"/>
			<xsl:value-of select="@year" />
			<xsl:value-of select="' '"/>
			<xsl:value-of select="$texts/text[find='PARA_ARTIGOS_DE']/replace" />
			<xsl:value-of select="' '"/>
			<xsl:value-of select="@year" />
		</xsl:variable>
		<xsl:variable name="other_columm_title">	
			<xsl:value-of select="$texts/text[find='ARTIGOS_PUBLICADOS_EM']/replace" />
			<xsl:value-of select="' '"/>
			<xsl:value-of select="@year" />
		</xsl:variable>
<!--FABIO - VERIFICANDO SE EXISTE CONTEUDO -->
                        <xsl:choose>
                                <xsl:when test="$root/table_list/table = ''">
                                  <tr>
				    <td>
				      <font face="arial" size="2" color="#800000">
					<xsl:value-of select="$texts/text[find='SEM_DADOS']/replace" />
				      </font>
                                    </td>
                                  </tr>
                                </xsl:when>
                                <xsl:otherwise>
                <tr>
                        <td colspan="2">

				<font face="arial" size="2" color="#0000A0">
					<xsl:value-of select="$table_title" />
				</font>
			</td>
		</tr>
		<tr>
			<td colspan="2">
                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
			<tr width="100%" bgcolor="#dfebeb">
                        <td width="1">&#160;</td>
						<td width="35%" align="center">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='REVISTAS_EM_ORDEM_ALFABETICA']/replace" />
								</strong>
							</small>
						</td>
						<td width="24%" colspan="4" align="center">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='CITACOES_EM']/replace" />&#160;<xsl:value-of select="@year" />&#160;<xsl:value-of select="$texts/text[find='PARA']/replace" />
								</strong>
							</small>
						</td>
						<td width="18%" colspan="3" align="center">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='ARTIGOS_PUBLICADOS_EM']/replace" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center" rowspan="2">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='FATOR_DE_IMPACTO']/replace" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center" rowspan="2">
							<small>
								<strong>
									<xsl:value-of select="$a_columm_title" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center" rowspan="2">
							<small>
								<strong>
									<xsl:value-of select="$other_columm_title" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center" rowspan="2">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='INDICE_DE_IMEDIATEZ']/replace" />
								</strong>
							</small>
						</td>
					</tr>

					<tr width="100%" bgcolor="#dfebeb">
                        <td width="1">&#160;</td>
						<td width="35%" align="center" nowrap="nowrap">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='TITULO']/replace" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="$texts/text[find='TODOS_ANOS']/replace" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="header/year_one_before" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="header/year_two_before" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="header/sum_two_year" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="header/year_one_before" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="header/year_two_before" />
								</strong>
							</small>
						</td>
						<td width="6%" align="center">
							<small>
								<strong>
									<xsl:value-of select="header/sum_two_year" />
								</strong>
							</small>
						</td>
					</tr>
                               
				         <xsl:apply-templates select="journal_list/journal">
                                                <xsl:with-param name="a_columm_title" select="$a_columm_title" />
                                                <xsl:with-param name="other_columm_title" select="$other_columm_title" />
                                        </xsl:apply-templates>                               
				
                                </table>
			</td>
		</tr>
		<tr>
			<td colspan="2">&#160;</td>
		</tr>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	
	
	<xsl:template match="journal">
		<xsl:param name="a_columm_title" />
		<xsl:param name="other_columm_title" />
		<xsl:comment>
	
		**** File: 05.xsl
		template match="journal"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
            <td width="1"><xsl:value-of select="position()"/>.&#160;</td>
			<td>
				<xsl:attribute name="width">35%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>				
				<xsl:apply-templates select="link" mode="externo" />
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='TODOS_ANOS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="citations_all_before" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="../header/year_one_before" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="year_before_list/year_before[@type='one']/citations" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="../header/year_two_before" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="year_before_list/year_before[@type='two']/citations" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="../header/sum_two_year" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="sum_two_year_citations" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="../header/year_one_before" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="year_before_list/year_before[@type='one']/articles" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="../header/year_two_before" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>			
				<xsl:value-of select="year_before_list/year_before[@type='two']/articles" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="../header/sum_two_year" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="sum_two_year_articles" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='FATOR_DE_IMPACTO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="impact_factor" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$a_columm_title" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="year_before_list/year_before[@type='zero']/citations" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$other_columm_title" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="year_before_list/year_before[@type='zero']/articles" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='INDICE_DE_IMEDIATEZ']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="imediacy_index" />&#160;
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>

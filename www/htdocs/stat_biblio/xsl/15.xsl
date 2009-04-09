<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="xsl/common.xsl" />	
<xsl:variable name="journal">
<xsl:copy-of select="//root/journal"/>
</xsl:variable>

<xsl:variable name="sorted_column_aux" select="/statistics/request-vars/sorted_column" />
<xsl:variable name="sorted_column">	
	<xsl:choose>
		<xsl:when test="string-length($sorted_column_aux) >= 1">
			<xsl:value-of select="$sorted_column_aux" />
		</xsl:when>
		<xsl:otherwise>1</xsl:otherwise>
	</xsl:choose>
</xsl:variable>

<xsl:template match="*" mode="html-body">
	<xsl:comment>

	**** File: 15.xsl
	template match="*" mode="html-body"
	
	</xsl:comment>
	<body>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td width="20%">
					<p align="center">
		    <xsl:choose>
			<xsl:when test="$journal/*">
							<a href="http://{$host_scisite}/scielo.php?script=sci_serial&amp;pid={$journal/journal/issn}&amp;lng={$lang}">
								<img align="bottom" border="0">
									<xsl:attribute name="src">
										<xsl:value-of select="concat('http://',$host_scisite,$path_image_revistas,$journal/journal/siglum,'/plogo.gif')" />
									</xsl:attribute>
								</img>
							</a>
			</xsl:when>
			<xsl:otherwise>
							<a href="http://{$host_scisite}/scielo.php?lng={$lang}">
								<img align="bottom" border="0">
									<xsl:attribute name="src">
										<xsl:value-of select="concat('http://',$host_scisite,'/img/',$lang,$path_image_logo)" />
									</xsl:attribute>
								</img>
							</a>
			</xsl:otherwise>
		    </xsl:choose>
					</p>
				</td>
				<td align="center" width="80%">
					<blockquote>
						<p align="left">
							<font size="+1" color="#000080">
								<xsl:value-of select="$root/title_list/title[@lang = $lang]" />
							</font>
			<xsl:if test="$journal/*">
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
			<xsl:apply-templates select="$root/table_list[@stat = 'source_data']/table" />
		</table>
		<xsl:call-template name="footer"></xsl:call-template>
	</body>
</xsl:template>

						
<xsl:template match="table">
	<xsl:comment>

	**** File: 15.xsl
	template match="table"
	
	</xsl:comment>
	<xsl:variable name="table_title">
		<xsl:value-of select="$texts/text[find='LISTA_DE_DADOS_FONTE_REFENTE_AOS_ANOS']/replace" />
		<xsl:value-of select="' '"/>
		<xsl:value-of select="$YNG_values" />
	</xsl:variable>

	<tr>
		<td colspan="2">
			<p align="left">
				<b>
					<font face="symbol" size="2" color="#0000eb">&#209;</font>
				</b> - <xsl:value-of select="$texts/text[find='CLIQUE_PARA_SELECIONAR_A_COLUNA_DE_ORDENACAO']/replace" />
				<br />
				<b>
					<font face="symbol" color="#eb0000" size="2">&#68;</font>
				</b> - <xsl:value-of select="$texts/text[find='INDICA_A_ORDEM_CORRENTE']/replace" />
			</p>
		</td>
	</tr>

	<tr>
		<td colspan="2">
			&#160;
		</td>
	</tr>	
	<!-- 
	<tr>
		<td colspan="2">
			<font face="arial" size="2" color="#0000A0">
				<xsl:value-of select="$table_title" />
			</font>
		</td>
	</tr>
	-->
                        <xsl:choose>
                                <xsl:when test="$root/total/articles = '0'">
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

			<table border="0" cellpadding="2" cellspacing="2" width="100%">
				<tr bgcolor="#dfebeb">
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'1'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='TITULO_DA_REVISTA_ANO']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'2'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='N_DE_FASCICULOS']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'3'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='N_DE_ARTIGOS']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'4'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='N_DE_CITACOES_CONCEDIDAS']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'5'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='N_DE_CITACOES_RECEBIDAS']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'6'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='MEDIA_DE_ARTIGOS_POR_FASCICULO']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'7'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_CONCEDIDAS_POR_FASCICULO']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'8'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_CONCEDIDAS_POR_ARTIGO']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'9'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_RECEBIDAS_POR_FASCICULO']/replace" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="table_cell_choose">
						<xsl:with-param name="the_column_number" select="'10'" />
						<xsl:with-param name="the_text">
							<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_RECEBIDAS_POR_ARTIGO']/replace" />
						</xsl:with-param>
					</xsl:call-template>
				</tr>
				<xsl:choose>
					<xsl:when test="$sorted_column = '2'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/issues" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '3'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/articles" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '4'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/citing" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '5'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/cited" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '6'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/avarages/articles_issue" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '7'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/avarages/citing/issue" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '8'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/avarages/citing/article" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '9'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/avarages/cited/issue" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:when test="$sorted_column = '10'">
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="descending" select="totals/avarages/cited/article" data-type="number"></xsl:sort>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="journal_list/journal">
							<xsl:sort order="ascending" select="label_list/label[@lang=$lang]" data-type="text"></xsl:sort>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>

				<!--
					12/05/2004
					a pedido do Rogerio, vamos inserir essa linha aqui:
				-->
				
				<tr bgcolor="#dfebeb">
					<td align="left">
						<b>
							<xsl:value-of select="'total'" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/issues" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/articles" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/citing" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/cited" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/avarages/articles_issue" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/avarages/citing/issue" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/avarages/citing/article" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/avarages/cited/issue" />
						</b>
					</td>
					<td align="right">
						<b>
							<xsl:value-of select="../../total/avarages/cited/article" />
						</b>
					</td>							
				</tr>
			</table>

		</td>
	</tr>
                                </xsl:otherwise>
                        </xsl:choose>
	<tr>
		<td colspan="2">&#160;</td>
	</tr>
</xsl:template>


<xsl:template match="journal"/>
	
	<xsl:template match="journal[stat_list/stat]">
		<xsl:comment>
	
		**** File: 15.xsl
		template match="journal"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='TITULO_DA_REVISTA']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">35%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>
				<b>
					<xsl:apply-templates select="link" mode="externo" />
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_FASCICULOS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/issues" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_ARTIGOS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/articles" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_CITACOES_CONCEDIDAS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/citing" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_CITACOES_RECEBIDAS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/cited" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_ARTIGOS_POR_FASCICULO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/avarages/articles_issue" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_CONCEDIDAS_POR_FASCICULO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/avarages/citing/issue" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_CONCEDIDAS_POR_ARTIGO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/avarages/citing/article" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_RECEBIDAS_POR_FASCICULO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/avarages/cited/issue" />&#160;
				</b>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_RECEBIDAS_POR_ARTIGO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<b>
					<xsl:value-of select="totals/avarages/cited/article" />&#160;
				</b>
			</td>
		</tr>
		<xsl:apply-templates select="stat_list/stat" />
	</xsl:template>


	<xsl:template match="stat">
		<xsl:comment>
	
		**** File: 15.xsl
		template match="stat"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='ANO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">35%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>				
				<xsl:value-of select="@year" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_FASCICULOS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="issues" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_ARTIGOS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="articles" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_CITACOES_CONCEDIDAS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="citing" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='N_DE_CITACOES_RECEBIDAS']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="cited" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_ARTIGOS_POR_FASCICULO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="avarages/articles_issue" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_CONCEDIDAS_POR_FASCICULO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>			
				<xsl:value-of select="avarages/citing/issue" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_CONCEDIDAS_POR_ARTIGO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="avarages/citing/article" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_RECEBIDAS_POR_FASCICULO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="avarages/cited/issue" />&#160;
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='MEDIA_DE_CITACOES_RECEBIDAS_POR_ARTIGO']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
				<xsl:value-of select="avarages/cited/article" />&#160;
			</td>
		</tr>
	</xsl:template>
	
	
	<xsl:template name="table_cell_choose">
		<xsl:param name="the_text"></xsl:param>
		<xsl:param name="the_column_number"></xsl:param>
		<xsl:comment>
	
		**** File: 15.xsl
		template name="x"
		
		</xsl:comment>
		<xsl:choose>
			<xsl:when test="$sorted_column = $the_column_number">
				<td align="center">
					<font color="#EB0000" size="2">
						<b>
							<xsl:value-of select="$the_text" />
						</b>
					</font>
					<br />
					<font face="symbol" color="#eb0000" size="2">&#68;</font>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="table_cell_form">
					<xsl:with-param name="the_sorted_column" select="$the_column_number" />
					<xsl:with-param name="the_text">
						<xsl:value-of select="$the_text" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	
	<xsl:template name="table_cell_form">
		<xsl:param name="the_text"></xsl:param>
		<xsl:param name="the_sorted_column"></xsl:param>
		<xsl:comment>
	
		**** File: 15.xsl
		template name="table_cell"
		
		</xsl:comment>
		<td align="center">
			<xsl:value-of select="$the_text" />
			<xsl:call-template name="form">
				<xsl:with-param name="hidden_01_name" select="'sorted_column'" />
				<xsl:with-param name="hidden_01_value" select="$the_sorted_column" />
				<xsl:with-param name="the_font_face" select="'symbol'" />
				<xsl:with-param name="the_font_size" select="'2'" />
				<xsl:with-param name="the_font_color" select="'#000080'" />
				<xsl:with-param name="the_bullet" select="'&#209;'" />
				<xsl:with-param name="the_label">
					<xsl:value-of select="''" />
				</xsl:with-param>
			</xsl:call-template>
		</td>
	</xsl:template>


</xsl:stylesheet>

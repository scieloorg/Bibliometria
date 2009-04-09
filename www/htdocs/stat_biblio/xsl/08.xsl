<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="xsl/common.xsl" />

    <xsl:variable name="journal">
        <xsl:copy-of select="//root/journal"/>
    </xsl:variable>
	
	<xsl:variable name="statistic_type_aux" select="/statistics/request-vars/statistic_type" />
	<xsl:variable name="statistic_type">	
		<xsl:choose>
			<xsl:when test="string-length($statistic_type_aux) >= 1">
				<xsl:value-of select="$statistic_type_aux" />
			</xsl:when>
			<xsl:otherwise>percentual_acumuled</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	

	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 08.xsl
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
					<td><xsl:value-of select="' '"/></td>
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
    
                <!--tr>
                    <td colspan="2">
                        <table border="0" width="100%" cellpadding="5" cellspacing="5">
                            <tr width="100%">
                                <td align="center" width="33%">
                                    <xsl:call-template name="form">
                                        <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                        <xsl:with-param name="hidden_01_value" select="'percentual_acumuled'" />
                                        <xsl:with-param name="the_font_face" select="'symbol'" />
                                        <xsl:with-param name="the_font_size" select="'1'" />
                                        <xsl:with-param name="the_font_color" select="'#000080'" />
                                        <xsl:with-param name="the_bullet" select="'&#183;'" />
                                        <xsl:with-param name="the_label">
                                            <xsl:value-of select="$texts/text[find='PERCENTUAL_ACUMULADO_DE_CITACOES']/replace" />
                                        </xsl:with-param>
                                        <xsl:with-param name="the_form_name" select="concat('form_', $state, '_percentual_acumuled_up')"/>
                                    </xsl:call-template>
                                </td>
                                <td align="center" width="33%">
                                    <xsl:call-template name="form">
                                        <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                        <xsl:with-param name="hidden_01_value" select="'total'" />
                                        <xsl:with-param name="the_font_face" select="'symbol'" />
                                        <xsl:with-param name="the_font_size" select="'1'" />
                                        <xsl:with-param name="the_font_color" select="'#000080'" />
                                        <xsl:with-param name="the_bullet" select="'&#183;'" />
                                        <xsl:with-param name="the_label">
                                            <xsl:value-of select="$texts/text[find='TOTAL_DE_CITACOES_POR_ANO']/replace" />
                                        </xsl:with-param>										
                                        <xsl:with-param name="the_form_name" select="concat('form_', $state, '_total_up')"/>
                                    </xsl:call-template>
                                </td>
                                <td align="center" width="33%">
                                    <xsl:call-template name="form">
                                        <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                        <xsl:with-param name="hidden_01_value" select="'percentual'" />
                                        <xsl:with-param name="the_font_face" select="'symbol'" />
                                        <xsl:with-param name="the_font_size" select="'1'" />
                                        <xsl:with-param name="the_font_color" select="'#000080'" />
                                        <xsl:with-param name="the_bullet" select="'&#183;'" />
                                        <xsl:with-param name="the_label">
                                            <xsl:value-of select="$texts/text[find='PERCENTUAL_DE_CITACOES_POR_ANO']/replace" />
                                        </xsl:with-param>
                                        <xsl:with-param name="the_form_name" select="concat('form_', $state, '_percentual_up')"/>                        
                                    </xsl:call-template>
                                </td>
        					</tr>
        				</table>
        			</td>
        		</tr-->       
                         
                <xsl:apply-templates select="$root/table_list[@stat = 'half_life']/table" />
                
                <!--tr>
                    <td colspan="2">
                        <table border="0" width="100%" cellpadding="5" cellspacing="5">
                            <tr width="100%">
                                <td align="center" width="33%">
                                    <xsl:call-template name="form">
                                        <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                        <xsl:with-param name="hidden_01_value" select="'percentual_acumuled'" />
                                        <xsl:with-param name="the_font_face" select="'symbol'" />
                                        <xsl:with-param name="the_font_size" select="'1'" />
                                        <xsl:with-param name="the_font_color" select="'#000080'" />
                                        <xsl:with-param name="the_bullet" select="'&#183;'" />
                                        <xsl:with-param name="the_label">
                                            <xsl:value-of select="$texts/text[find='PERCENTUAL_ACUMULADO_DE_CITACOES']/replace" />
                                        </xsl:with-param>
                                        <xsl:with-param name="the_form_name" select="concat('form_', $state, '_percentual_acumuled_down')"/>
                                    </xsl:call-template>
                                </td>
                                <td align="center" width="33%">
                                    <xsl:call-template name="form">
                                        <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                        <xsl:with-param name="hidden_01_value" select="'total'" />
                                        <xsl:with-param name="the_font_face" select="'symbol'" />
                                        <xsl:with-param name="the_font_size" select="'1'" />
                                        <xsl:with-param name="the_font_color" select="'#000080'" />
                                        <xsl:with-param name="the_bullet" select="'&#183;'" />
                                        <xsl:with-param name="the_label">
                                            <xsl:value-of select="$texts/text[find='TOTAL_DE_CITACOES_POR_ANO']/replace" />
                                        </xsl:with-param>										
                                        <xsl:with-param name="the_form_name" select="concat('form_', $state, '_total_down')"/>
                                    </xsl:call-template>
                                </td>
                                <td align="center" width="33%">
                                    <xsl:call-template name="form">
                                        <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                        <xsl:with-param name="hidden_01_value" select="'percentual'" />
                                        <xsl:with-param name="the_font_face" select="'symbol'" />
                                        <xsl:with-param name="the_font_size" select="'1'" />
                                        <xsl:with-param name="the_font_color" select="'#000080'" />
                                        <xsl:with-param name="the_bullet" select="'&#183;'" />
                                        <xsl:with-param name="the_label">
                                            <xsl:value-of select="$texts/text[find='PERCENTUAL_DE_CITACOES_POR_ANO']/replace" />
                                        </xsl:with-param>
                                        <xsl:with-param name="the_form_name" select="concat('form_', $state, '_percentual_down')"/>                        
                                    </xsl:call-template>
                                </td>
        					</tr>
        				</table>
        			</td>
        		</tr-->                
			</table>
			<xsl:call-template name="footer"></xsl:call-template>
		</body>
	</xsl:template>

							
	<xsl:template match="table">
		<xsl:comment>
	
		**** File: 08.xsl
		template match="table"
		
		</xsl:comment>
		<xsl:variable name="table_title">
			<xsl:value-of select="$texts/text[find='LISTAGEM_DE_VIDA_MEDIA_DE_REVISTAS']/replace" />
			<xsl:value-of select="' - '"/>
			<xsl:value-of select="$texts/text[find='ANO_BASE']/replace" />
			<xsl:value-of select="' '"/>
			<xsl:value-of select="@year" />
		</xsl:variable>
        <xsl:variable name="anchor" select="concat('year_', @year)"/>
        <a name="{$anchor}"/>

	<tr>
            <td colspan="2"><xsl:value-of select="'&#160;'"/></td>
        </tr>


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
                <table border="0" width="100%" cellpadding="5" cellspacing="5">
                    <tr width="100%">
                        <td align="center" width="33%">
                            <xsl:call-template name="form">
                                <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                <xsl:with-param name="hidden_01_value" select="'percentual_acumuled'" />
                                <xsl:with-param name="the_font_face" select="'symbol'" />
                                <xsl:with-param name="the_font_size" select="'1'" />
                                <xsl:with-param name="the_font_color" select="'#000080'" />
                                <xsl:with-param name="the_bullet" select="'&#183;'" />
                                <xsl:with-param name="the_label">
                                    <xsl:value-of select="$texts/text[find='PERCENTUAL_ACUMULADO_DE_CITACOES']/replace" />
                                </xsl:with-param>
                                <xsl:with-param name="the_form_name" select="concat('form_', $state, '_percentual_acumuled_', $anchor)"/>
                            </xsl:call-template>
                        </td>
                        <td align="center" width="33%">
                            <xsl:call-template name="form">
                                <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                <xsl:with-param name="hidden_01_value" select="'total'" />
                                <xsl:with-param name="the_font_face" select="'symbol'" />
                                <xsl:with-param name="the_font_size" select="'1'" />
                                <xsl:with-param name="the_font_color" select="'#000080'" />
                                <xsl:with-param name="the_bullet" select="'&#183;'" />
                                <xsl:with-param name="the_label">
                                    <xsl:value-of select="$texts/text[find='TOTAL_DE_CITACOES_POR_ANO']/replace" />
                                </xsl:with-param>										
                                <xsl:with-param name="the_form_name" select="concat('form_', $state, '_total_', $anchor)"/>
                            </xsl:call-template>
                        </td>
                        <td align="center" width="33%">
                            <xsl:call-template name="form">
                                <xsl:with-param name="hidden_01_name" select="'statistic_type'" />
                                <xsl:with-param name="hidden_01_value" select="'percentual'" />
                                <xsl:with-param name="the_font_face" select="'symbol'" />
                                <xsl:with-param name="the_font_size" select="'1'" />
                                <xsl:with-param name="the_font_color" select="'#000080'" />
                                <xsl:with-param name="the_bullet" select="'&#183;'" />
                                <xsl:with-param name="the_label">
                                    <xsl:value-of select="$texts/text[find='PERCENTUAL_DE_CITACOES_POR_ANO']/replace" />
                                </xsl:with-param>
                                <xsl:with-param name="the_form_name" select="concat('form_', $state, '_percentual_', $anchor)"/>                        
                            </xsl:call-template>
                        </td>
					</tr>
				</table>
			</td>

		</tr>
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

					<tr bgcolor="#dfebeb">
						<!--td width="96%" align="center" colspan="12"-->
						<td width="96%" align="center" colspan="13">
							<b>
								<xsl:value-of select="$texts/text[find='DISTRIBUICAO_CRONOLOGICA_DE_CITACOES_DE_REVISTAS_CITANTES']/replace" />
							</b>
							<!-- -->
							<br />
							<xsl:value-of select="'('"/>
							<font color="Maroon">
								<xsl:choose>
									<xsl:when test="$statistic_type = 'total'">
										<xsl:value-of select="$texts/text[find='TOTAL_DE_CITACOES']/replace" />
									</xsl:when>
									<xsl:when test="$statistic_type = 'percentual'">
										<xsl:value-of select="$texts/text[find='PERCENTUAL_DE_CITACOES']/replace" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$texts/text[find='PERCENTUAL_ACUMULADO_DE_CITACOES']/replace" />
									</xsl:otherwise>
								</xsl:choose>							
							</font>
							<xsl:value-of select="' '"/>
    						<xsl:value-of select="$texts/text[find='DE_REVISTAS_DE']/replace" />
							<xsl:value-of select="' '"/>
							<b>
								<xsl:value-of select="@year" />
							</b>
							<xsl:value-of select="' '"/>
							<xsl:value-of select="$texts/text[find='PARA_ARTIGOS_PUBLICADOS_DURANTE_OS_ANOS_INDICADOS']/replace" />
							<xsl:value-of select="')'"/>
							
						</td>
					</tr>

					<tr width="100%" bgcolor="#dfebeb">
                        <td width="1">&#160;</td>
                    
						<td width="6%" align="center">
							<strong>
                                <xsl:choose>
                                    <xsl:when test="$statistic_type = 'percentual_acumuled'">
        								<xsl:value-of select="$texts/text[find='VIDA_MEDIA']/replace" />
                                    </xsl:when>
                                    <xsl:otherwise>
        								<xsl:value-of select="$texts/text[find='TOTAL_CITACOES']/replace" />
                                    </xsl:otherwise>
                                </xsl:choose>
							</strong>
						</td>
						<td width="30%" align="center">
							<strong>
								<xsl:value-of select="$texts/text[find='REVISTA']/replace" />
							</strong>
						</td>
						
						<xsl:apply-templates select="header/year_before_list/year_before/year" />

					</tr>

					<xsl:apply-templates select="journal_list/journal" />

				</table>
				
			</td>
		</tr>
		<tr>
			<td colspan="2"><p><xsl:value-of select="'&#160;'"/></p></td>
		</tr>

				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	
	
	<xsl:template match="journal">
		<xsl:comment>
	
		**** File: 08.xsl
		template match="journal"
		
		</xsl:comment>
		<tr>
			<xsl:attribute name="bgcolor">#F2F2F2</xsl:attribute>
			<xsl:attribute name="onMouseOver">this.style.backgroundColor='#DBE5EA';</xsl:attribute>
			<xsl:attribute name="onMouseOut">this.style.backgroundColor='#F2F2F2';</xsl:attribute>
            <td width="1"><xsl:value-of select="position()"/>.&#160;</td>
			<td>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="$statistic_type = 'percentual_acumuled'">
    				        <xsl:value-of select="$texts/text[find='VIDA_MEDIA']/replace" />
                        </xsl:when>
                        <xsl:otherwise>
    				        <xsl:value-of select="$texts/text[find='TOTAL_CITACOES']/replace" />
                        </xsl:otherwise>
                    </xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="width">5%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>
				<xsl:attribute name="align">right</xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="$statistic_type = 'percentual_acumuled'">
            				<xsl:value-of select="half_life" />
                        </xsl:when>
                        <xsl:otherwise>
    				        <xsl:value-of select="citations_all_before" />
                        </xsl:otherwise>
                    </xsl:choose>
				<xsl:value-of select="' '"/>
			</td>
			<td>
				<xsl:attribute name="title">
					<xsl:value-of select="$texts/text[find='REVISTA']/replace" />
				</xsl:attribute>
				<xsl:attribute name="width">6%</xsl:attribute>
				<xsl:attribute name="nowrap">nowrap</xsl:attribute>
				<xsl:attribute name="align">left</xsl:attribute>
				<xsl:apply-templates select="link" mode="externo" />
				<xsl:value-of select="' '"/>
			</td>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'zero'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'one'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'two'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'three'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'four'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'five'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'six'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'seven'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'eight'" />
			</xsl:call-template>
			
			<xsl:call-template name="years">
				<xsl:with-param name="year" select="'nine'" />
			</xsl:call-template>
		</tr>
		
	</xsl:template>
	
	
	<xsl:template match="year">
		<td width="6%" align="center">
			<strong>
				<xsl:value-of select="." />
			</strong>
		</td>
	</xsl:template>
	
	
	<xsl:template name="years">
		<xsl:param name="year"></xsl:param>
		<xsl:comment>
	
		**** File: 08.xsl
		template name="years"
		
		</xsl:comment>
		<td>
			<xsl:attribute name="title">
				<xsl:value-of select="../../header/year_before_list/year_before[@type = $year]/year" />
			</xsl:attribute>
			<xsl:attribute name="width">6%</xsl:attribute>
			<xsl:attribute name="align">right</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$statistic_type = 'total'">
					<xsl:value-of select="year_before_list/year_before[@type = $year]/total" />
				</xsl:when>
				<xsl:when test="$statistic_type = 'percentual'">
					<xsl:value-of select="year_before_list/year_before[@type = $year]/percentual" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="year_before_list/year_before[@type = $year]/percentual_acumuled" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="'&#160;'"/>
		</td>
	</xsl:template>
	
</xsl:stylesheet>

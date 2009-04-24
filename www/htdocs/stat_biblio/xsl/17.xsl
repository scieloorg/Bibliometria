<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="xsl/common.xsl"/>
	<xsl:variable name="journal">
		<xsl:copy-of select="//root/journal"/>
	</xsl:variable>
	<xsl:variable name="sorted_column_aux" select="/statistics/request-vars/sorted_column"/>
	<xsl:variable name="sorted_column">
		<xsl:choose>
			<xsl:when test="string-length($sorted_column_aux) >= 1">
				<xsl:value-of select="$sorted_column_aux"/>
			</xsl:when>
			<xsl:otherwise>1</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 17.xsl
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
											<xsl:attribute name="src"><xsl:value-of select="concat('http://',$host_scisite,$path_image_revistas,$journal/journal/siglum,'/plogo.gif')"/></xsl:attribute>
										</img>
									</a>
								</xsl:when>
								<xsl:otherwise>
									
									<xsl:call-template name="logo"/>
									<!-- nao testado, nao encontrei a pagina -->
								</xsl:otherwise>
							</xsl:choose>
						</p>
					</td>
					<td align="center" width="80%">
						<blockquote>
							<p align="left">
								<font size="+1" color="#000080">
									<xsl:value-of select="root/title_list/title[@lang = $lang]"/>
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
									<xsl:value-of select="root/subtitle_list/subtitle[@lang = $lang]"/>
								</font>
							</p>
						</blockquote>
					</td>
				</tr>
				<tr>
					<td colspan="2">&#160;</td>
				</tr>
				<xsl:apply-templates select="root/header"/>
				<xsl:apply-templates select="root/cooperation_list"/>
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
					<xsl:apply-templates select="country_one" mode="header"/>
					<xsl:apply-templates select="country_two_list" mode="header"/>
					<xsl:apply-templates select="journal" mode="header"/>
					<xsl:apply-templates select="year_source_list" mode="header"/>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">&#160;</td>
		</tr>
	</xsl:template>
	<xsl:template match="*" mode="header">
		<tr width="100%" bgcolor="#dfebeb">
			<td width="35%" align="left">
				<small>
					<strong>
						<xsl:apply-templates select="." mode="header_label"/>
					</strong>
				</small>
			</td>
		</tr>
		<xsl:apply-templates select="." mode="header_data"/>
	</xsl:template>
	<xsl:template match="*" mode="header_data">
		<tr bgcolor="#F2F2F2" onMouseOver="this.style.backgroundColor='#DBE5EA';" onMouseOut="this.style.backgroundColor='#F2F2F2';" width="35%" nowrap="nowrap">
			<td>
				<xsl:apply-templates select="." mode="header_data_value"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="country_two_list[*]" mode="header_data">
		<xsl:apply-templates select="*" mode="header_data"/>
	</xsl:template>
	<xsl:template match="*[*]" mode="header_data_value">
		<xsl:apply-templates select="*" mode="header_data_value"/>
	</xsl:template>
	<xsl:template match="*" mode="header_data_value">
		<xsl:value-of select="concat('&#160;',.)"/>
	</xsl:template>
	<xsl:template match="*[text()='all' or text() = 'sum'] | country_two_list[text() = '1']" mode="header_data_value">
		<xsl:variable name="key" select="concat(name(), '_', .)"/>
		<xsl:value-of select="concat('&#160;',$texts/text[find=$key]/replace)"/>
	</xsl:template>
	<xsl:template match="*" mode="header_label">
		<xsl:variable name="key" select="concat('header_', name())"/>
		<xsl:value-of select="$texts/text[find=$key]/replace"/>
	</xsl:template>
	<xsl:template match="cooperation_list[not(*)]">
		<xsl:variable name="key" select="concat('empty_', name())"/>
		<tr>
			<td>&#160;</td>
			<td align="left">
				<blockquote>
					<p>
						<font color="#800000">
							<xsl:value-of select="$texts/text[find=$key]/replace"/>
						</font>
					</p>
				</blockquote>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="cooperation_list">
		<xsl:variable name="cooperationList" select="."/>
		<xsl:variable name="groupYear">
			<xsl:apply-templates select="." mode="group_year"/>
		</xsl:variable>
		<xsl:variable name="groupYearSort">
			<xsl:for-each select="$groupYear/year_source">
				<xsl:sort select="." data-type="number" order="ascending"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="groupCountry">
			<xsl:apply-templates select="." mode="group_country"/>
		</xsl:variable>
		<tr>
			<td colspan="2">
				<table border="0" align="center" cellpadding="2" cellspacing="2" width="60%">
					<tr bgcolor="#dfebeb">
						<!--
                        <td width="1%" align="left">&#160;</td>
                        <td width="15%" align="left"><b><xsl:value-of select="$texts/text[find='column_year_source']/replace"/></b></td>
                        <td width="50%" align="left"><b><xsl:value-of select="$texts/text[find='column_country_second']/replace"/></b></td>
                        <td width="15%" align="right"><b><xsl:value-of select="$texts/text[find='column_frequency']/replace"/></b></td>
                        <td width="19%" align="left"><b><xsl:value-of select="$texts/text[find='column_link']/replace"/></b></td>
-->
						<td>
							<b>
								<xsl:value-of select="$texts/text[find='column_country_second']/replace"/>
							</b>
						</td>
						<xsl:for-each select="$groupYear/year_source">
							<xsl:sort select="." data-type="number" order="ascending"/>
							<td>
								<b>
									<xsl:value-of select="."/>
								</b>
							</td>
						</xsl:for-each>
						<!-- aqui -->
						<xsl:if test="not(starts-with($YNG_values/text(),'sum'))">
							<td>
								<b>total</b>
							</td>
						</xsl:if>
					</tr>
					<xsl:for-each select="$groupCountry/country_second">
						<tr bgcolor="#F2F2F2" onMouseOver="this.style.backgroundColor='#DBE5EA';" onMouseOut="this.style.backgroundColor='#F2F2F2';">
							<xsl:variable name="country" select="."/>
							<td>
								<xsl:value-of select="$country"/>
							</td>
							<xsl:for-each select="$groupYearSort/year_source">
								<xsl:variable name="year" select="."/>
								<xsl:if test="not($cooperationList/cooperation[country_second = $country and year_source=$year])">
									<td>-</td>
								</xsl:if>
								<xsl:apply-templates select="$cooperationList/cooperation[country_second = $country][year_source=$year]"/>
							</xsl:for-each>
							<!-- aqui -->
							<xsl:if test="not(starts-with($YNG_values/text(),'sum'))">
								<td>
									<b>
										<xsl:value-of select="sum($cooperationList/cooperation[country_second=$country]/frequency)"/>
									</b>
								</td>
							</xsl:if>
						</tr>
					</xsl:for-each>
					<tr bgcolor="#F2F2F2" onMouseOver="this.style.backgroundColor='#DBE5EA';" onMouseOut="this.style.backgroundColor='#F2F2F2';">
						<td>
							<b>total</b>
						</td>
						<xsl:for-each select="$groupYearSort/year_source">
							<xsl:variable name="year" select="."/>
							<td>
								<b>
									<xsl:value-of select="sum($cooperationList/cooperation[year_source=$year]/frequency)"/>
								</b>
							</td>
						</xsl:for-each>
						<!-- aqui -->
						<xsl:if test="not(starts-with($YNG_values/text(),'sum'))">
							<td>
								<b>
									<xsl:value-of select="sum($cooperationList/cooperation/frequency)"/>
								</b>
							</td>
						</xsl:if>
					</tr>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="cooperation">
		<td>
			<xsl:value-of select="frequency"/>
		</td>
	</xsl:template>
	<xsl:template match="cooperation[link]">
		<td>
			<xsl:variable name="url">
				<xsl:apply-templates select="link/url" mode="externo"/>
			</xsl:variable>
			<a href="{$url}" target="_blank">
				<xsl:value-of select="frequency"/>
			</a>
		</td>
	</xsl:template>
	<!--    
    <xsl:template match="cooperation">
        <tr bgcolor="#F2F2F2" 
            onMouseOver="this.style.backgroundColor='#DBE5EA';this.style.color='#1a1aff'"
            onMouseOut="this.style.backgroundColor='#F2F2F2';this.style.color='#000000'">
            <td width="1%" align="left"><xsl:value-of select="order"/>.&#160;</td>
            <td width="15%" align="left"><xsl:value-of select="year_source"/></td>
            <td width="50%" align="left"><xsl:value-of select="country_second"/></td>
            <td width="15%" align="right"><xsl:value-of select="frequency"/></td>
            <td width="15%" align="left">
                <xsl:if test="not(link)">-</xsl:if>
                <xsl:apply-templates select="link" mode="externo"/>
            </td>
        </tr>
    </xsl:template>

	<xsl:template match="link[@type='iah']" mode="externo">
		<xsl:comment>

		**** File: 17.xsl
		template match="link" mode="externo"

		</xsl:comment>
		<xsl:variable name="url">
			<xsl:apply-templates select="url" mode="externo" />
		</xsl:variable>
		<xsl:variable name="label">
			<xsl:value-of select="label_list/label[@lang = $lang]" />
		</xsl:variable>
		<a href="{$url}" target="_blank">
			<xsl:value-of select="$label" />
		</a>
	</xsl:template>
-->
	<xsl:template match="cooperation_list" mode="group_year">
		<xsl:apply-templates select="cooperation[position()=1]" mode="group_year"/>
	</xsl:template>
	<xsl:template match="cooperation" mode="group_year">
		<xsl:param name="yearGroup"/>
		<xsl:choose>
			<xsl:when test="not(contains($yearGroup, year_source))">
				<xsl:copy-of select="year_source"/>
				<xsl:apply-templates select="following-sibling::cooperation[position()=1]" mode="group_year">
					<xsl:with-param name="yearGroup" select="concat($yearGroup,',',year_source)"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="following-sibling::cooperation[position()=1]" mode="group_year">
					<xsl:with-param name="yearGroup" select="$yearGroup"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="cooperation_list" mode="group_country">
		<xsl:apply-templates select="cooperation[position()=1]" mode="group_country"/>
	</xsl:template>
	<xsl:template match="cooperation" mode="group_country">
		<xsl:copy-of select="country_second"/>
		<xsl:variable name="country" select="country_second"/>
		<xsl:apply-templates select="following-sibling::cooperation[country_second != $country][position()=1]" mode="group_country"/>
	</xsl:template>
</xsl:stylesheet>

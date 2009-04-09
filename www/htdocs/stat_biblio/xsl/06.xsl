<?xml version="1.0" encoding="iso-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:include href="xsl/common.xsl" />	

	<xsl:template match="*" mode="html-body">
		<xsl:comment>
	
		**** File: 06.xsl
		template match="*" mode="html-body"
		
		</xsl:comment>
		<body>
			<h3>estado 06</h3>
			<xsl:call-template name="footer"></xsl:call-template>

		</body>
	</xsl:template>

</xsl:stylesheet>
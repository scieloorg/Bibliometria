<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet  version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" omit-xml-declaration="yes"></xsl:output>
	<xsl:template match="/">
		<xsl:copy-of select="/root"></xsl:copy-of>
	</xsl:template>

</xsl:stylesheet>

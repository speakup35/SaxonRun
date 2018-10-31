<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<xsl:param name="country">zh-cn</xsl:param>

<xsl:key name="Arguments-lookup" match="Arguments/Lang" use="country"/>
<xsl:variable name="message-top" select="document('lookup.xml')/auto_message_text/Arguments"/>
<xsl:template match="refbody">
	<xsl:value-of select="title"/>
	<xsl:apply-templates select="$message-top">
	<xsl:with-param name="curr-refbody" select="."/>
	</xsl:apply-templates> 
</xsl:template>

<xsl:template match="Arguments">
	<xsl:param name="curr-refbody"/>
	<xsl:value-of select="key('Arguments-lookup', $country)/value"/>
</xsl:template>


</xsl:stylesheet>
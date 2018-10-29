<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<xsl:key name="Arguments-lookup" match="Lang" use="country"/>
<xsl:variable name="message-top" select="document('lookup.xml')/auto_message_text"/>
<xsl:template match="refbody">
	<xsl:value-of select="title"/>
	<xsl:apply-templates select="$message-top">
	<xsl:with-param name="curr-refbody" select="."/>
	</xsl:apply-templates> 
</xsl:template>

<xsl:template match="Arguments">
	<xsl:param name="curr-refbody"/>
	<xsl:value-of select="key('Arguments-lookup', $curr-refbody/section/title)/value"/>
</xsl:template>

<!--xsl:variable name='values' select='document("lookup.xml")/auto_message_text/Arguments/Lang/value'/>
<xsl:variable name='countries' select='document("lookup.xml")/auto_message_text/Arguments/Lang/country'/>

<xsl:template match='refbody'>
	<places>
        <xsl:apply-templates select='section'/>
	</places>
</xsl:template>

<xsl:template match='section'>
 <xsl:variable name='value-sec' select='value'/>
 <place>
  <state><xsl:value-of select='$countries[@fips=current( )/state]/@name'/></state>
  <city><xsl:value-of select='$values[@fips=$value-sec]/@name'/></city>
 </place>
</xsl:template-->
</xsl:stylesheet>
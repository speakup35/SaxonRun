<?xml version="1.0"?>
<xsl:transform
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0">
 <xsl:output method="text"/>
<!-- A -->
 <xsl:key name="state-lookup" match="state" use="abbr"/>
<!-- B -->
 <xsl:variable name="states-top" select="document('states.xml')/states"/>
 <xsl:template match="label">
 <xsl:value-of select="name"/>
 <xsl:text> of </xsl:text>
<!-- C -->
 <xsl:apply-templates select="$states-top">
 <xsl:with-param name="curr-label" select="."/>
 </xsl:apply-templates>
 </xsl:template>
<!-- D -->
 <xsl:template match="states">
 <xsl:param name="curr-label"/>
 <xsl:value-of select="key('state-lookup', $curr-label/address/state)/name"/>
 </xsl:template>
</xsl:transform>
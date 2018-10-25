<?xml version="1.0"?>
<!-- E -->
 <xsl:transform
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:s="http://states.data"
 version="1.0">
 <xsl:output method="text"/>
<!-- F -->
 <xsl:key name="state-lookup" match="s:state" use="s:abbr"/>
<!-- G -->
 <xsl:variable name="states-top" select="document('')/*/s:states"/>
 <xsl:template match="label">
 <xsl:value-of select="name"/>
 <xsl:text> of </xsl:text>
 <xsl:apply-templates select="$states-top">
 <xsl:with-param name="curr-label" select="."/>
 </xsl:apply-templates>
 </xsl:template>
<!-- H -->
 <xsl:template match="s:states">
 <xsl:param name="curr-label"/>
 <xsl:value-of select="key('state-lookup', $curr-label/address/state)/s:name"/>
 </xsl:template>
<!-- I -->
 <s:states>
 <s:state><s:abbr>CO</s:abbr><s:name>Colorado</s:name></s:state>
 <s:state><s:abbr>CT</s:abbr><s:name>Connecticut</s:name></s:state>
 <s:state><s:abbr>ID</s:abbr><s:name>Idaho</s:name></s:state>
 <s:state><s:abbr>NJ</s:abbr><s:name>New Jersey</s:name></s:state>
 </s:states>
</xsl:transform>
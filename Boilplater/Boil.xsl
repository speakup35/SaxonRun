<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<xsl:param name="country">en</xsl:param>
<xsl:param name="defaultcn">en</xsl:param>
<xsl:key name="Arguments-lookup" match="m_locale" use="country"/>
<xsl:variable name="message-top" select="document('lookup.xml')/auto_message_text"/>

<xsl:template match="refbody">
	<xsl:apply-templates select="$message-top">
	<xsl:with-param name="curr-refbody" select="section"/>
	</xsl:apply-templates> 
</xsl:template>

<xsl:template match="auto_message_text">
	<xsl:param name="curr-refbody"/>
	<xsl:variable name="defaulttl" select="key('Arguments-lookup', $defaultcn)/value"/>
	<xsl:variable name="outtl" select="key('Arguments-lookup', $country)/value"/>
	<xsl:for-each select="$curr-refbody/title">
		<xsl:variable name="eachtitle" select="index-of($defaulttl, .)"/>
		<!--input><xsl:value-of select="."/></input-->
		<xsl:if test="$eachtitle > 0">
			<title><xsl:value-of select="subsequence($outtl,$eachtitle,1)"/></title>
		</xsl:if>
	</xsl:for-each>
	<xsl:for-each select="$curr-refbody/p">
		<xsl:variable name="eachp" select="index-of($defaulttl, .)"/>
		<xsl:choose>
		<xsl:when test="$eachp > 0">
			<p><xsl:value-of select="subsequence($outtl,$eachp,1)"/></p>
		</xsl:when>
		<xsl:otherwise>
			<p><xsl:value-of select="."/></p>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>

</xsl:template>
</xsl:stylesheet>

<!--
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<xsl:param name="country">en</xsl:param>

<xsl:key name="Arguments-lookup" match="Arguments/m_locale" use="country"/>
<xsl:key name="Severity-lookup" match="Severity/m_locale" use="country"/>
<xsl:key name="Serviceable-lookup" match="Serviceable/m_locale" use="country"/>
<xsl:key name="CalledHome-lookup" match="CalledHome/m_locale" use="country"/>
<xsl:key name="UserAction-lookup" match="UserAction/m_locale" use="country"/>
<xsl:key name="No-lookup" match="No/m_locale" use="country"/>
<xsl:key name="Internal-lookup" match="Internal/m_locale" use="country"/>
<xsl:key name="DateReviewed-lookup" match="DateReviewed/m_locale" use="country"/>
<xsl:key name="Informational-lookup" match="Informational/m_locale" use="country"/>

<xsl:variable name="message-top" select="document('lookup.xml')/auto_message_text"/>

<xsl:template match="refbody">
	<xsl:param name="curr-refbody"/>
	<xsl:apply-templates select="$message-top">
		<xsl:with-param name="curr-refbody" select="."/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="auto_message_text">
	<xsl:param name="curr-refbody"/>
	<reference id="msg_FQXHMCP1105I" otherprops="External" xml:lang="en">
	 <refbody>
		<section>
		  <title><xsl:value-of select="key('Arguments-lookup', $country)/value"/></title>
		  <p><varname>[arg1]</varname>  Pattern name</p>
		  <p><varname>[arg2]</varname>  Server or chassis name</p>
		</section>
		<section otherprops="Internal">
		  <title><xsl:value-of select="key('Internal-lookup', $country)/value"/></title>
		  <p><xsl:value-of select="key('No-lookup', $country)/value"/></p>
		</section>
		<section>
		  <title><xsl:value-of select="key('Severity-lookup', $country)/value"/></title>
		  <p><xsl:value-of select="key('Informational-lookup', $country)/value"/></p>
		</section>
		<section>
		  <title><xsl:value-of select="key('Serviceable-lookup', $country)/value"/></title>
		  <p><xsl:value-of select="key('No-lookup', $country)/value"/></p>
		</section>
		<section>
		  <title><xsl:value-of select="key('CalledHome-lookup', $country)/value"/></title>
		  <p><xsl:value-of select="key('No-lookup', $country)/value"/></p>
		</section>
		<section><title><xsl:value-of select="key('UserAction-lookup', $country)/value"/></title>Information only; no action is required.</section>
		<section otherprops="Internal">
		  <title><xsl:value-of select="key('DateReviewed-lookup', $country)/value"/></title>
		  <p>4/3/2014</p>
		</section>
	  </refbody>
	</reference>
</xsl:template>

</xsl:stylesheet>
-->

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<!-- -->
<xsl:param name="country">zh-cn</xsl:param>

<xsl:key name="Arguments-lookup" match="Arguments/Lang" use="country"/>
<xsl:key name="Severity-lookup" match="Severity/Lang" use="country"/>
<xsl:key name="Serviceable-lookup" match="Serviceable/Lang" use="country"/>
<xsl:key name="CalledHome-lookup" match="CalledHome/Lang" use="country"/>
<xsl:key name="UserAction-lookup" match="UserAction/Lang" use="country"/>
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
		  <title>Internal Event</title>
		  <p>No</p>
		</section>
		<section>
		  <title><xsl:value-of select="key('Severity-lookup', $country)/value"/></title>
		  <p>Informational</p>
		</section>
		<section>
		  <title><xsl:value-of select="key('Serviceable-lookup', $country)/value"/></title>
		  <p>No</p>
		</section>
		<section>
		  <title><xsl:value-of select="key('CalledHome-lookup', $country)/value"/></title>
		  <p>No</p>
		</section>
		<section><title><xsl:value-of select="key('UserAction-lookup', $country)/value"/></title>Information only; no action is required.</section>
		<section otherprops="Internal">
		  <title>Reviewed</title>
		  <p>4/3/2014</p>
		</section>
	  </refbody>
	</reference>
</xsl:template>

</xsl:stylesheet>
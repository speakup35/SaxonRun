<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<xsl:param name="country">zh-cn</xsl:param>
<xsl:param name="defaultcn">en</xsl:param>
<xsl:key name="Arguments-lookup" match="Lang" use="country"/>
<xsl:variable name="message-top" select="document('lookup.xml')/auto_message_text/Arguments"/>

<xsl:template match="refbody">
	<xsl:apply-templates select="$message-top">
	<xsl:with-param name="curr-refbody" select="section/title"/>
	</xsl:apply-templates> 
</xsl:template>

<xsl:template match="Arguments">
	<xsl:param name="curr-refbody"/>
	<xsl:variable name="defaulttl" select="key('Arguments-lookup', $defaultcn)/value"/>
	<xsl:variable name="outtl" select="key('Arguments-lookup', $country)/value"/>
	<!--
	<xsl:for-each select="$defaulttl">
		<def><xsl:value-of select="."/></def>
	</xsl:for-each>
	<xsl:for-each select="$outtl">
		<trans><xsl:value-of select="."/></trans>
	</xsl:for-each>
	-->
	<!--
	<input><xsl:value-of select="$curr-refbody"/></input>
	<output><xsl:value-of select="key('Arguments-lookup', $defaultcn)/value"/></output>
	<xsl:for-each select="key('Arguments-lookup', $defaultcn)/value">
		<titlel><xsl:value-of select="."/></titlel>
	</xsl:for-each>
			
	<defaulttl><xsl:value-of select="subsequence($defaulttl,index-of($defaulttl, 'Arguments'),index-of($defaulttl, 'Arguments'))"/></defaulttl>
	<outtl><xsl:value-of select="subsequence($outtl,index-of($defaulttl, 'Arguments'),index-of($defaulttl, 'Arguments'))"/></outtl>
	-->
	<xsl:for-each select="$curr-refbody">
		<xsl:variable name="tagname" select="name()"/>
		<xsl:variable name="eachtitle" select="index-of($defaulttl, .)"/>
		<title><xsl:value-of select="."/></title>
		<!-- xsl:if test=". = subsequence($defaulttl,$eachtitle,$eachtitle)" -->
			<output><xsl:value-of select="subsequence($outtl,$eachtitle,1)"/></output>
		<!-- /xsl:if -->
	</xsl:for-each>
	<!--
	<lookup>
		<xsl:value-of select="."/>
	</lookup>
	<ref>
		<xsl:value-of select="$curr-refbody"/>
	</ref>
	-->
</xsl:template>

</xsl:stylesheet>

<!--
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output encoding='utf-8' indent='yes'/>

<xsl:param name="country">zh-cn</xsl:param>

<xsl:key name="Arguments-lookup" match="Arguments/Lang" use="country"/>
<xsl:key name="Severity-lookup" match="Severity/Lang" use="country"/>
<xsl:key name="Serviceable-lookup" match="Serviceable/Lang" use="country"/>
<xsl:key name="CalledHome-lookup" match="CalledHome/Lang" use="country"/>
<xsl:key name="UserAction-lookup" match="UserAction/Lang" use="country"/>
<xsl:key name="No-lookup" match="No/Lang" use="country"/>
<xsl:key name="Internal-lookup" match="Internal/Lang" use="country"/>
<xsl:key name="DateReviewed-lookup" match="DateReviewed/Lang" use="country"/>
<xsl:key name="Informational-lookup" match="Informational/Lang" use="country"/>

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
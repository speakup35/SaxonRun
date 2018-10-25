<?xml version="1.0"?>
<!--=  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =
        fips_no_keys.xsl
        Purpose:
                Demonstrate using a lookup table located
                in an external document.
        Author: Thomas B Passin
        Creation date: 7 March 2004
        Demonstrates using a lookup table and the use of
        document( ) to refer to nodes in the table.
=  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =-->
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
        indent='yes' is used just to try to get a more 
        readable output.  It has no effect on the 
        functionality of the output.
-->
<xsl:output encoding='utf-8' indent='yes'/>

<!--
        It is better to declare these global variables here 
        rather than to just use the expressions inline.
    The lookup table is contained in the file "fips.xml".
-->
<xsl:variable name='cities' 
     select='document("fips.xml")/fips/state/city'/>
<xsl:variable name='states' 
     select='document("fips.xml")/fips/state'/>

<xsl:template match='places'>
	<places>
			<xsl:apply-templates select='place'/>
	</places>
</xsl:template>

<!--
        This template demonstrates two methods to specify 
        which part of the lookup table to use.  Note the use 
        of current( ), which lets us get the context-derived 
        value into the lookup table predicate.  Otherwise the 
        use of "city" or "state" would be taken to be elements 
        in the lookup table, not in the source document.

        The variable is another way to achieve the same
        thing.
-->
<xsl:template match='place'>
 <xsl:variable name='city-fips' select='city'/>
 <place>
  <state><xsl:value-of 
     select='$states[@fips=current( )/state]/@name'/></state>
  <city><xsl:value-of 
     select='$cities[@fips=$city-fips]/@name'/></city>
 </place>
</xsl:template>


</xsl:stylesheet>
<?xml version="1.0" encoding='utf-8'?>

<!--=  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  

=  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =

    fips_internal_codes.xsl

    Purpose:

        Demonstrate using a lookup table located 

        within the stylesheet itself.

    Author: Thomas B Passin    

    Creation date: 7 March 2004

    

    Demonstrates inserting the lookup table using a

    namespace, and the use of document("") to refer

    to nodes in the stylesheet itself.

=  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  

=  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =  =-->

<!--

    Note the use of exclude-result-prefixes to prevent

    the "lu" namespace from appearing in the output

    document (where it would be harmless but mildly

    annoying).

-->

<xsl:stylesheet version="1.0" 

    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"

    xmlns:lu='http://example.com/lookup'

    exclude-result-prefixes='lu'>

    

<!--

    indent='yes' is used just to try to get a more readable

    output.  It has no effect on the functionality of the

    output.

-->

<xsl:output encoding='utf-8' indent='yes'/>

   

<!--

    It is better to declare these global variables here rather 

    than to just se the expressions inline.

-->

<xsl:variable name='cities' select='document("")/xsl:stylesheet/lu:fips/state/city'/>

<xsl:variable name='states' select='document("")/xsl:stylesheet/lu:fips/state'/>

   

<xsl:template match='places'>

<places>

    <xsl:apply-templates select='place'/>

</places>    

</xsl:template>

   

<!--

    This template demonstrates two methods to specify which 

    part of the lookup table to use.  Note the use of 

    current( ), which lets us get the context-derived value 

    into the lookup table predicate.  Otherwise the use of 

    "city" or "state" would be taken to be elements in the 

    lookup table, not in the source document.  

    

    The variable is another way to achieve the same

    thing.

-->

<xsl:template match='place'>

    <xsl:variable name='city-fips' select='city'/>

    <place>

        <state><xsl:value-of select='$states[@fips=current( )/state]/@name'/></state>

        <city><xsl:value-of select='$cities[@fips=$city-fips]/@name'/></city>

    </place>

</xsl:template>

   

<!--

    The internal lookup table.  The exact namespace used does 

    not matter as long as there is one.

-->

<lu:fips>

     <state fips="17" name="ILLINOIS">

         <city fips="57381" name="PALOS HEIGHTS"/>

         <city fips="35307" name="HINSDALE"/>

         <city fips="20149" name="DIXMOOR"/>

         <city fips="84090" name="YOUNGSDALE"/>

         <city fips="14000" name="CHICAGO"/>

         <city fips="70629" name="SOUTH CHICAGO HEIGHTS"/>

     </state>

     <state fips="18" name="INDIANA">

         <city fips="1810" name="ANTIOCH"/>

         <city fips="36000" name="INDIANAPOLIS"/>

         <city fips="5050" name="BETHEL VILLAGE"/>

         <city fips="17740" name="DENHAM"/>

     </state>

     <state fips="26" name="MICHIGAN">

         <city fips="74010" name="SIMMONS"/>

         <city fips="22000" name="DETROIT"/>

         <city fips="43180" name="KINCHELOE"/>

         <city fips="73260" name="SHERMAN TWP"/>

     </state>

 </lu:fips>

 

</xsl:stylesheet>
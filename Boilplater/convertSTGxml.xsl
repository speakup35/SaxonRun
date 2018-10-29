<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                extension-element-prefixes="saxon xalanredirect lxslt">

<xsl:param name="inputfile"/>
<xsl:param name="maptable" required="no" as="document-node()"/>
<xsl:param name="outputtype">HTML</xsl:param>
<xsl:param name="outputdir">MessageOutput</xsl:param>
<xsl:param name="revisiondate">20100501</xsl:param>
<xsl:param name="product">BlackTip</xsl:param>
<!-- Product param has become the official string name including machine number, etc. Created "code_name" as a replacement.-->
<xsl:param name="code_name">Blacktip</xsl:param>
<!-- Options include: sysx, flex -->
<xsl:param name="product_family">flex</xsl:param>
<!-- Options include: IMM, UEFI, DSA, CMM, DVD --> 
<xsl:param name="msgtype">IMM</xsl:param>

<xsl:output
    method="xml"
    encoding="utf-8"
    indent="yes"
    doctype-system="map.dtd"
    doctype-public="-//OASIS//DTD DITA Map//EN"
    omit-xml-declaration="no"
/>

<xsl:param name="outext">.dita</xsl:param>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="Events">
  <map>
      <xsl:element name="title">Messages</xsl:element>
      <xsl:apply-templates select="*">
          <xsl:sort select="@ID" order="ascending"/>
      </xsl:apply-templates>
  </map>
</xsl:template>

<xsl:template match="Event">
  <xsl:variable name="fbefore">
        <xsl:value-of select="substring-before(@ID, '-')"/>
  </xsl:variable>

  <xsl:variable name="fafter">
	<xsl:value-of select="substring-after(@ID, '-')"/>
  </xsl:variable>
  
  <xsl:variable name="isDSA">
	<xsl:value-of select="substring-after($fafter, '-')"/>
  </xsl:variable>
  
  <xsl:variable name="filename">
	<xsl:choose>
		<xsl:when test="string-length($fbefore) > 0 and string-length($isDSA) = 0">
			<xsl:value-of select="concat($fbefore, $fafter)"/>
        		<xsl:value-of select="$outext"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="@ID"/>
       			<xsl:value-of select="$outext"/>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:variable>

  <xsl:variable name="id">
  <xsl:text>msg_</xsl:text>
  <xsl:value-of select="@ID"/>
  </xsl:variable>

  <xsl:variable name="navtitle">
	<xsl:value-of select="@ID"/>
        <!-- ... SOMETHING HERE ... -->
  </xsl:variable>

  <xsl:variable name="tempPropsType">
           <xsl:value-of select="normalize-space(Internal)"/>
  </xsl:variable>

  <xsl:variable name="propsType">
                <xsl:choose>
                   <xsl:when test="$tempPropsType = 'Yes'">
                   <xsl:text>Internal</xsl:text>
                   </xsl:when>
                   <xsl:otherwise>
                   <xsl:text>External</xsl:text>
                   </xsl:otherwise>
                   </xsl:choose>
 </xsl:variable>

  <topicref href="{$filename}" navtitle="{$navtitle}" otherprops="{$propsType}" type="reference">
    <xsl:call-template name="write-page">
      <xsl:with-param name="filename" select="$filename"/>
      <xsl:with-param name="page">

         <xsl:variable name="sourceDate">
                  <xsl:value-of select="normalize-space(DateReviewed)"/>
        </xsl:variable>
        <xsl:variable name="eventDate">
             <xsl:value-of select="substring-after($sourceDate,', ')"/>

             <xsl:variable name="mo">
                  <xsl:value-of select="substring-before($sourceDate,' ')" />
             </xsl:variable>
             <xsl:choose>
                  <xsl:when test="$mo = 'January'">01</xsl:when>
                  <xsl:when test="$mo = 'February'">02</xsl:when>
                  <xsl:when test="$mo = 'March'">03</xsl:when>
                  <xsl:when test="$mo = 'April'">04</xsl:when>
                  <xsl:when test="$mo = 'May'">05</xsl:when>
                  <xsl:when test="$mo = 'June'">06</xsl:when>
                  <xsl:when test="$mo = 'July'">07</xsl:when>
                  <xsl:when test="$mo = 'August'">08</xsl:when>
                  <xsl:when test="$mo = 'September'">09</xsl:when>
                  <xsl:when test="$mo = 'October'">10</xsl:when>
                  <xsl:when test="$mo = 'November'">11</xsl:when>
                  <xsl:when test="$mo = 'December'">12</xsl:when>
                  <xsl:when test="$mo = ''">99</xsl:when>
             </xsl:choose>
             <xsl:variable name="day">
                     <xsl:value-of select="replace(normalize-space(substring-after($sourceDate,$mo)),', ','')"/>
                  </xsl:variable>
             <xsl:value-of select="substring($day,1,2)"/>
             <!-- <xsl:value-of select="substring($sourceDate,string-length($mo)index-of($sourceDate,' ')+1,index-of($sourceDate,' '))" /> -->
         </xsl:variable>


        <!--  <xsl:variable name="updateVar">
              <xsl:choose>
              <xsl:when test="$eventDate > $revisiondate">
                    <xsl:text>v59</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                   <xsl:text></xsl:text>
              </xsl:otherwise>
              </xsl:choose>
          </xsl:variable> -->

          <xsl:message>
            <xsl:text>revisionDate = </xsl:text>
          <xsl:value-of select="$revisiondate"/>
          <xsl:text>eventDate = </xsl:text>
          <xsl:value-of select="$eventDate"/>
          <!-- <xsl:text>updateVar = </xsl:text>
          <xsl:value-of select="$updateVar"/> -->
          </xsl:message>

          <!-- <reference id="{$id}" otherprops="{$propsType}" rev="{$updateVar}" xml:lang="en"> -->
          <reference id="{$id}" otherprops="{$propsType}" xml:lang="en"> 	  
		  <xsl:element name="title">
		       <xsl:value-of select="@ID"/>
			   <xsl:text> : </xsl:text>
			   <xsl:apply-templates select="MessageString"/>
		  </xsl:element>
		  <xsl:element name="titlealts">
		        <xsl:element name="navtitle">
					<xsl:value-of select="@ID"/>
				</xsl:element>
				<xsl:element name="searchtitle">
					<xsl:value-of select="$product"/>
					<xsl:text> - </xsl:text>
					<xsl:value-of select="@ID"/>
					<xsl:choose>
					<xsl:when test="string-length($fbefore) > 0">
						<xsl:text>, </xsl:text>
					<xsl:value-of select="concat($fbefore, $fafter)"/>
						<xsl:text>, </xsl:text>
                    <xsl:value-of select="concat('0x', $fbefore, $fafter)"/>
					</xsl:when>
					</xsl:choose>
				</xsl:element>
		  </xsl:element>
		  <xsl:element name="shortdesc">
                <!--<xsl:value-of select="MessageString"/>-->
                <xsl:apply-templates select="MessageString"/>
          </xsl:element>
		<xsl:element name="refbody">
            <xsl:if test="$msgtype='LXCA'">
                <xsl:apply-templates select="Arguments"/>
            </xsl:if>
			<xsl:if test="$msgtype!='DSA'">
				<xsl:if test="../MessageDescription!=../MessageString">
					<xsl:apply-templates select="MessageDescription"/>
				</xsl:if>
            </xsl:if>
              <xsl:apply-templates select="Internal"/>
              <xsl:apply-templates select="Severity"/>
              <xsl:apply-templates select="AlertCategory"/>
              <xsl:apply-templates select="LogSource"/>
              <xsl:apply-templates select="Serviceable"/>
              <xsl:apply-templates select="Recoverable"/>
              <xsl:apply-templates select="Example"/>
              <xsl:apply-templates select="LEDs"/>
              <xsl:apply-templates select="CIMMessageID"/>
              <xsl:apply-templates select="Notifiable"/>
              <xsl:apply-templates select="SNMPTrapID"/>
              <xsl:apply-templates select="CalledHome"/>
              <xsl:apply-templates select="SystemImpact"/>
              <xsl:apply-templates select="UserAction"/>
              <xsl:apply-templates select="InternalNotes"/>
              <xsl:apply-templates select="DateAdded"/>
              <xsl:apply-templates select="DateReviewed"/>
              <xsl:apply-templates select="RelatedLinks"/>
              <!-- Code added by Aksel Davis 3/17/14 to handle Sys X DSA external links. DSA shouldn't have any related links except these. -->
              <!-- Removed Sys X conditional: <xsl:if test="$product_family='sysx' and $msgtype='DSA'"> -->
              <xsl:if test="$msgtype='DSA'">
				<xsl:element name="section">
				<xsl:element name="title">Related Links</xsl:element>
				<xsl:element name="p">
                    <ul>
                       <li><xref href="http://datacentersupport.lenovo.com" scope="external">Lenovo Support Web site</xref></li>
                        <li><xref href="http://datacentersupport.lenovo.com/documents/LNVO-DSA" scope="external">Latest level of DSA</xref></li>
                    </ul>
				</xsl:element>
				</xsl:element>
               </xsl:if>
         </xsl:element>
		 </reference>
       </xsl:with-param>
    </xsl:call-template>
  </topicref>
</xsl:template>

<xsl:template match="Arguments">
	<xsl:element name="section">
		<xsl:element name="title">Arguments</xsl:element>
				<xsl:apply-templates/>
  	</xsl:element>
</xsl:template>

<xsl:template match="Arguments/node()">
    <xsl:if test="contains(local-name(),'arg')">
        <p><varname>[<xsl:value-of select="local-name()"/>]</varname><xsl:text> </xsl:text><xsl:apply-templates/></p>
    </xsl:if>
</xsl:template>

<!-- Poorly formed code. Probably need to add varname to .dtd and remove Event// from match attribute -->
<xsl:template match="Event//varname">
    <!--<xsl:copy>
        <xsl:apply-templates/>
    </xsl:copy>-->
    <xsl:copy-of select="."/>
</xsl:template>

<!-- Poorly formed code. Probably need to add "br" and "code" to .dtd and remove Event// from match attribute -->
<xsl:template match="Event//br">
    <!-- Mask the <br/> tag. We check for that later -->
</xsl:template>
<!-- Match code tags and then check if peer tag is <br/>. If so, include linebreak using codeblock instead of codeph -->
<xsl:template match="Event//code">
        <xsl:choose>
            <xsl:when test="../br"><codeblock><xsl:apply-templates/></codeblock></xsl:when>
            <xsl:otherwise><codeph><xsl:apply-templates/></codeph></xsl:otherwise>
        </xsl:choose>
</xsl:template>

<xsl:template match="MessageDescription">
  <xsl:element name="section">
     <xsl:apply-templates/>
                <xsl:variable name="fbefore">
                              <xsl:value-of select="substring-before(../@ID, '-')"/>
                </xsl:variable>

                <xsl:variable name="fafter">
	                      <xsl:value-of select="substring-after(../@ID, '-')"/>
                </xsl:variable>

                <xsl:variable name="isDSA">
                	<xsl:value-of select="substring-after($fafter, '-')"/>
                </xsl:variable>
               <xsl:choose>
               <xsl:when test="string-length($fbefore) > 0 and string-length($isDSA) = 0">
                    <p>May also be shown as
		    <xsl:value-of select="concat($fbefore, $fafter)"/>
                    <xsl:text> or </xsl:text>
                    <xsl:value-of select="concat('0x', $fbefore, $fafter)"/>
                     </p>
	        </xsl:when>
               </xsl:choose>
  </xsl:element>
</xsl:template>

<xsl:template match="SNMPTrapID">
    <xsl:variable name="testtrapID">
	<xsl:value-of select="normalize-space(.)"/>
	</xsl:variable>
	<xsl:if test="string-length($testtrapID) > 0">
		<xsl:element name="section">
			<xsl:element name="title">SNMP Trap ID</xsl:element>
			<xsl:element name="p">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:if>
</xsl:template>

<xsl:template match="AlertCategory">
	<xsl:element name="section">
		<xsl:element name="title">Alert Category</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="LogSource">
	<xsl:element name="section">
		<xsl:element name="title">Log Source</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="Serviceable">
	<xsl:element name="section">
		<xsl:element name="title">Serviceable</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="Internal">
	<xsl:element name="section">
		<xsl:attribute name="otherprops">Internal</xsl:attribute>
		<xsl:element name="title">Internal Event</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
 </xsl:template>

<xsl:template match="Recoverable">
	<xsl:element name="section">
		<xsl:element name="title">Recoverable</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="Notifiable">
	<xsl:element name="section">
		<xsl:element name="title">Notifiable</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="Severity">
	<xsl:element name="section">
		<xsl:element name="title">Severity</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="MessageString">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="InternalNotes">
	<xsl:element name="section">
		<xsl:attribute name="otherprops">Internal</xsl:attribute>
		<xsl:element name="title">Internal Notes</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="Example">
	<xsl:element name="section">
		<xsl:element name="title">Example Message</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>

</xsl:template>

<xsl:template match="CIMMessageID">
	<xsl:element name="section">
		<xsl:element name="title">CIM Information</xsl:element>
		<xsl:element name="p"><b>Prefix:</b>
		<xsl:value-of select="normalize-space(../CIMMessagePrefix)"/>
		</xsl:element>
		<xsl:element name="p">and <b>ID:</b>
		<xsl:value-of select="normalize-space(../CIMMessageID)"/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="SystemImpact">
	<xsl:element name="section">
		<xsl:element name="title">System Impact</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="LEDs">
	<xsl:element name="section">
		<xsl:element name="title">Chassis LED that is Lit</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="CalledHome">
	<xsl:element name="section">
		<xsl:element name="title">Automatically Notify Support</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="UserAction">
	<xsl:element name="section">
		<xsl:element name="title">User Response</xsl:element>
			<xsl:apply-templates/>
	</xsl:element>
</xsl:template>

<!-- Code added by Aksel Davis on 5/7/13 to handle Related Links -->
<xsl:template match="RelatedLinks">
	<xsl:element name="section">
		<xsl:element name="title">Related Links</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>
<xsl:template match="RelatedLinks/node()">
        <xsl:copy>
	<xsl:choose>
            <xsl:when test=".//li">
                    <!-- Multiple links exist -->
                    <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                    <!-- Only a single link -->
                    <xsl:if test="string-length(normalize-space(.)) > 0">
                                    <xsl:choose>
                                            <xsl:when test="./a/@href">
                                                    <!-- External link -->
                                                    <xsl:if test="string-length(normalize-space(./a/@href)) > 0"><xref href="{normalize-space(./a/@href)}"><xsl:value-of select="a"/></xref></xsl:if>    
                                            </xsl:when>
                                            <xsl:otherwise>
                                                    <!-- Assuming its an ID -->
                                                    <xsl:call-template name="perform_id_lookup"><xsl:with-param name="oldid" select="normalize-space(.)"/></xsl:call-template>
                                            </xsl:otherwise>
                                    </xsl:choose>
                    </xsl:if>
            </xsl:otherwise>
	</xsl:choose>
        </xsl:copy>
</xsl:template>

<!-- Matches if there are multiple links -->
<xsl:template match="RelatedLinks//li">
	<!-- Determines whether link is an ID or external -->
        <xsl:copy>
	<xsl:choose>
		<xsl:when test="./a/@href">
			<!-- External link -->
			<xsl:if test="string-length(normalize-space(./a/@href)) > 0"><xref href="{normalize-space(./a/@href)}"><xsl:value-of select="a"/></xref></xsl:if>    
		</xsl:when>
		<xsl:otherwise>
			<!-- Assuming its an ID -->
			<xsl:call-template name="perform_id_lookup"><xsl:with-param name="oldid" select="normalize-space(.)"/></xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
        </xsl:copy>
</xsl:template> 



<!-- Performs the actual lookup of the ID and returns the dita file on success and empty string on failure. -->
<xsl:template name="perform_id_lookup">
	<xsl:param name="oldid"/>
        <xsl:variable name="newref">
            <xsl:for-each select="$maptable/map//Link[ID=$oldid]">
                <xsl:value-of select="REF"/>
            </xsl:for-each>            
        </xsl:variable>
        <xsl:variable name="linktext">
            <xsl:if test="string-length($newref) > 0">
                <xsl:for-each select="$maptable/map//Link[ID=$oldid]">
                    <xsl:value-of select="URLDesc"/>
                </xsl:for-each>   
            </xsl:if>
        </xsl:variable>    
        <xsl:choose>
                <xsl:when test="string-length($newref) > 0">
                    <xsl:choose>
                        <xsl:when test="contains(normalize-space($newref),'http') or contains(normalize-space($newref),'https')">
                            <xref href="{$newref}" scope="external"><xsl:if test="string-length(normalize-space($linktext)) > 0"><xsl:value-of select="$linktext"/></xsl:if></xref>
                        </xsl:when>
                        <xsl:otherwise>
                            <xref href="{$newref}"></xref>
                        </xsl:otherwise>
                    </xsl:choose>                    
                </xsl:when>
                <xsl:otherwise>
                        <xref href="DOES_NOT_EXIST_IN_TABLE"></xref>
                        <!--Send a message saying it doesn't exist in table-->
                        <xsl:message><xsl:text>WARNING: ID </xsl:text><xsl:value-of select="$oldid"/><xsl:text> does not exist in lookup table</xsl:text></xsl:message>
                </xsl:otherwise>
        </xsl:choose>
</xsl:template>

<xsl:template match="DateAdded">
	<xsl:element name="section">
		<xsl:attribute name="otherprops">Internal</xsl:attribute>
		<xsl:element name="title">Date Message Added</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="DateReviewed">
	<xsl:element name="section">
		<xsl:attribute name="otherprops">Internal</xsl:attribute>
		<xsl:element name="title">Reviewed</xsl:element>
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="a">

  <xsl:variable name="myhref">
     <xsl:value-of select="@href"/> 
  </xsl:variable>

 <xref href="{$myhref}" scope="external">
     <xsl:apply-templates/>
  </xref>
</xsl:template>


<xsl:template match="*">
  <xsl:copy>
  <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="text()">
  <xsl:copy/>
</xsl:template>

<!-- write content to a file -->
<xsl:template name="write-page">
  <xsl:param name="filename"/>
  <xsl:param name="page"/>
  <!-- generate the file in the specified directory -->
  <xsl:variable name="outfile">
    <xsl:if test="$outputdir and $outputdir!='.'">
      <xsl:text>file:///</xsl:text>
      <xsl:value-of select="$outputdir"/>
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:value-of select="$filename"/>
    </xsl:variable>
  <xsl:message><xsl:value-of select="$filename"/></xsl:message>
  <xsl:message><xsl:value-of select="$outfile"/></xsl:message>

  <xsl:result-document href="{$outfile}"
                method="xml"
                  encoding="UTF-8"
                  doctype-system="reference.dtd"
                  doctype-public="-//OASIS//DTD DITA Reference//EN"
                  omit-xml-declaration="no"
                  indent="no">
      <xsl:copy-of select="$page"/>
    </xsl:result-document>
</xsl:template>
</xsl:stylesheet>

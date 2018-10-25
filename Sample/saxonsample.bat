java -jar c:\saxon\saxon9he.jar -t -s:fips_lu_data.xml -xsl:fips_no_keys.xsl -o:fips_out_1.xml
java -jar c:\saxon\saxon9he.jar -t -s:fips_lu_data.xml -xsl:fips_internal_codes.xsl -o:fips_out_2.xml
java -jar c:\saxon\saxon9he.jar -t -s:labels.xml -xsl:lookup.xsl -o:state_out.xml
java -jar c:\saxon\saxon9he.jar -t -s:labels.xml -xsl:state-summary.xsl -o:state-summary_out.xml
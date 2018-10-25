@REM java -jar c:\saxon\saxon9he.jar -t 
@REM	-s:C:\Lenovo\Messages\Published\FlexSystem\chassis_accipiter\cmm\Accipiter.xml 
@REM	-xsl:C:\Lenovo\BuildTools\buildCMMMessagesPDF.xsl 
@REM	-o:C:\Users\fchen21\Downloads\SaxonRun\Output\cmm_messages_listing.dita 
@REM	outputdir=C:\Users\fchen21\Downloads\SaxonRun\Output 
@REM	product="Enterprise chassis" 
@REM	code_name="Accipiter" 
@REM	product_family="Flex" 
@REM	msgtype="CMM" 
@REM	+maptable="C:\Lenovo\Messages\Published\FlexSystem\chassis_accipiter\mapping_table\dw1lv_chassis_infocenter_table_v4.0.0.xml"

java -jar c:\saxon\saxon9he.jar -t -s:C:\Lenovo\Messages\Published\FlexSystem\chassis_accipiter\cmm\Accipiter.xml -xsl:C:\Lenovo\BuildTools\buildCMMMessagesPDF.xsl -o:C:\Users\fchen21\Downloads\SaxonRun\Output\cmm_messages_listing.dita outputdir=C:\Users\fchen21\Downloads\SaxonRun\Output product="Enterprise chassis" code_name="Accipiter" product_family="Flex" msgtype="CMM" +maptable="C:\Lenovo\Messages\Published\FlexSystem\chassis_accipiter\mapping_table\dw1lv_chassis_infocenter_table_v4.0.0.xml"

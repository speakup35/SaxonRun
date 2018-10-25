@REM java -jar c:\saxon\saxon9he.jar -t 
@REM 	-s:C:\Lenovo\Messages\Published\FlexSystem\chassis_accipiter\cmm\Accipiter.xml 
@REM 	-xsl:C:\Lenovo\BuildTools\pullCallHomeEvents.xsl 
@REM 	-o:C:\Users\fchen21\Downloads\SaxonRun\Output\call_home_events.dita 
@REM 	outputdir=C:\Users\fchen21\Downloads\SaxonRun\Output
@REM 	product="Enterprise chassis" 
@REM 	code_name="Accipiter" 
@REM 	product_family="Flex" 
@REM 	msgtype="CMM"

java -jar c:\saxon\saxon9he.jar -t -s:C:\Lenovo\Messages\Published\FlexSystem\chassis_accipiter\cmm\Accipiter.xml -xsl:C:\Lenovo\BuildTools\pullCallHomeEvents.xsl -o:C:\Users\fchen21\Downloads\SaxonRun\Output\call_home_events.dita outputdir=C:\Users\fchen21\Downloads\SaxonRun\Output	product="Enterprise chassis" code_name="Accipiter" product_family="Flex" msgtype="CMM"
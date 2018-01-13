# ewosXSLTViewer
XSLT stylesheet to view aquaculture data in the Ewos XML in a web browser

Data exported from Aquaculture management systems in the Ewos XML format can be styled using this sheet. 
External javascript/CSS libraries (jQuery, Bootstrap, DataTables with plugins support the styling and provides simple export functionality.

In order to use the stylesheet directly, put the sheet, css and js file in the same directory as the Ewos XML file and add declaration
to the xml (export) file, like:
?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="ewos.xsl" ?>

Then open the Ewos XML (not the xsl) in an XSLT-enabled web browser. 
NB: Firefox can display the result this directly from the local file system. 
For security reasons Google Chrome has by default disabled XSLT rendering from local files, but the file can be displayed using 
any local or external webserver.

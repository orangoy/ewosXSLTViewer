<?php
$url = $_GET['url'];

if(!empty($url)) render($url);
else { echo '
<html>
<form>
Enter URL to XML file:<br>
<input type="text" name="url" />
<input type="submit" value="Render" />
</form>
</html>
';

}

function render($url){
$xslDoc = new DOMDocument();
$xslDoc->load("ewos.xsl");

$xmlDoc = new DOMDocument();
$xmlDoc->load($url);

$proc = new XSLTProcessor();
$proc->importStylesheet($xslDoc);

echo $proc->transformToXML($xmlDoc);

}
<?php 

	include_once("functions.php");
	include_once("class.IniFile.php");
	$iniObj = new IniFile("ini/stat.ini");
	$iniArr = $iniObj->parse();
	$xml_node =  $iniObj->getXML();
	$xml = XML_HEADER . $xml_node;
	die($xml);


	$url = "http://serverofi.bireme.br:2424/xml/02.xml";
	//echo("\$url: |" . $url . "|");
	//die();

	// Ha´ dois tipos de XML, as estaticas e as criadas dinamicamente
	// Dependendo dessas duas opcoes, escolhemos o a funcao para conseguir
	// o XML que e´ mais adequada:
	// XML estatico (url NAO contem o sinal '?') -> getXML($url);
	// XML dinamico (url     contem o sinal '?') -> document_post($url);
	$pos = strpos($url, "?");
	if ($pos === false)
	{
	    // NAO contem o sinal '?'...
		$xml_content = getXML($url);
	}
	else
	{
		$xml_content = document_post($url);
	}

	// Faz a transformacao se nao for debug=xml
	
	if ($debug == "xml")
	{
		die($xml_content);
	}
	else
	{
		$xml_content = trim($xml_content);
		//echo("\$xml_content: |" . $xml_content . "|");
		//$state = "getRoot";
		//$xsl_path = $iniArr["XSL"][$state];
		//die("\$xsl_path: |" . $xsl_path . "|");
		$xml_node = transform($xml_content, $xsl_path);
		//echo($xml_node);
		$header = XML_HEADER;
		die($header . $xml_node);
		
		//$state = "main";
		//$xsl_path = $iniArr["XSL"][$state];
		//$html_content = transform($xml_content, $xsl_path);
		//echo($html_content);
		
	}

?>
<?php 

include_once("old2new.inc.php");
include_once("class.IniFile.php");
include_once("class.XSLTransformer.php");

define("NL", "\n<br>");
define("XML_HEADER", "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n");
define("XSL_HEADER", "<?xml-stylesheet type='text/xsl' href='http://tamar.bireme.br:1128/xsl/main.xsl'?>\n");


function getXML($url)
{
	// get a web page into an array and print it out
	$fcontents = file($url);
	$str_xml = "";
	while ( list($line_num, $line) = each ($fcontents) )
	{
		$str_xml .= $line;
	    //echo "<b>Line $line_num:</b>; ", htmlspecialchars($line), "<br>\n";
	}
	return $str_xml;
}


function transform($xml, $xsl, $debug = false)
{
	$xslt = new XSLTransformer();
	$xslt->setXml($xml);
	$xslt->setXsl($xsl);
	$xslt->transform();
	$error = $xslt->getError();
	if ($error)
	{
		$xslt->destroy();
		die($error);
	}
	$tranformation = utf8_decode($xslt->getOutput());
	if ($debug)
	{
		die($tranformation);
	}
	$xslt->destroy();
	return $tranformation;
}


function changeDangerousCharacters($the_string)
{
	$the_string = str_replace("&", "&amp;", $the_string);
	$the_string = str_replace("<", "&lt;", $the_string);
	$the_string = str_replace(">", "&gt;", $the_string);
	$the_string = str_replace("\"", "&quot;", $the_string);
	$the_string = str_replace("\&quot;", "&quot;", $the_string);
	return $the_string;
}


// Funcao para fazer o submit via POST
function document_post($url, $content = "")
{
	$content = str_replace("\\\"","\"",$content);
	$content = str_replace("\\\\","\\",$content);
	$content = str_replace("\n","",$content);
	$content = str_replace("\r","",$content);
	// Strip URL  
	$url_parts = parse_url($url);
	$host = $url_parts["host"];
	$port = ($url_parts["port"]) ? $url_parts["port"] : 80;
	$path = $url_parts["path"];
	$query = $url_parts["query"];
														/* 
														echo("\$url:" . NL);
														print_r($url);
														echo(NL . NL);
														echo("\$url_parts:" . NL);
														print_r($url_parts);
														echo(NL . NL);
														//die();
														*/
	if ($content != "")
	{
		$query .= "&content=" . urlencode($content);
	}
	$timeout = 10;
	$contentLength = strlen($query);
	// Generate the request header 
    $ReqHeader =  
      "POST $path HTTP/1.0\n". 
      "Host: $host\n". 
      "User-Agent: PostIt\n". 
      "Content-Type: application/x-www-form-urlencoded\n". 
      "Content-Length: $contentLength\n\n". 
      "$query\n"; 
	// Open the connection to the host 
	$fp = fsockopen($host, $port, &$errno, &$errstr, $timeout);
	$result = "";
	fputs($fp, $ReqHeader);
	if ($fp)
	{
		while (!feof($fp))
		{
			$result .= fgets($fp, 4096);
		}
	}
	$result = strstr($result,"<");
	//echo("\$result: |" . $result . "|" . NL);	
	return $result; 
}

function getLastProcessDate($date, $lang){
	
	$texts['en']='Last processed date ';
	$texts['pt']='Data do último processamento ';
	$texts['es']='Fecha del último procesamiento ';

	if ($lang == 'en'){
		$month = array('','Jan','Feb','Mar','Apr','May','June','July','Ago','Sept','Oct','Nov','Dec');

		$d = $month[intval(substr($date,4,2))].'-'.substr($date,6,2).'-'.substr($date,0,4);
	} else {
		$d = substr($date,6,2).'-'.substr($date,4,2).'-'.substr($date,0,4);

	}

	return $texts[$lang].$d;
}
?>
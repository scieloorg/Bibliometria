<?php 

	include_once("functions.php");
	include_once("class.IniFile.php");
	include_once("class.RequestVars.php");
	
	$iniObj = new IniFile("ini/stat.ini");
	$iniArr = $iniObj->parse();
	$xml_node_ini =  $iniObj->getXML();
	$requestVars = new RequestVars();

	$xml_node_request_vars = $requestVars->getVarsXml();
	$array_request_vars = $requestVars->getVarsArray();
	/* 
	$xml_node_request_uri = "<request_uri>" . $HTTP_SERVER_VARS["REQUEST_URI"] .  "</request_uri>" ;
	$xml_node_request_uri = str_replace("&amp;", "&", $xml_node_request_uri);
	$xml_node_request_uri = str_replace("&", "&amp;", $xml_node_request_uri);
	echo(NL); echo(NL);
	echo("\$xml_node_request_uri: |" . $xml_node_request_uri . "|");
	echo(NL); echo(NL);
	*/
	/* 
	echo("\$array_request_vars:" . NL);
	print_r($array_request_vars);
	echo(NL); echo(NL);
	die();
	*/
	if ($array_request_vars["state"] != "")
	{
		$state = $array_request_vars["state"];
	}
	else
	{
		//echo("Warning: no state was defined, so default 02 is runing the business...");
		$state = "02";
	}
	
	//echo("\$xml_url: |" . $xml_url . "|");
	//die();
	
	if ($array_request_vars["xml"] != "")
	{
		$xml_url = $array_request_vars["xml"];
	}
	else
	{
//		$xml_url = "http://serverofi.bireme.br:2424/xml/02.xml";
		$xml_url = "http://" . $iniArr["hosts"]["server"] . $iniArr["hosts"]["static_xml"] . "/" . $state . ".xml";
	}

	if ($array_request_vars["server_action"] != "")
	{
		$server_action = $array_request_vars["server_action"];
	}
	else
	{
		$server_action = "";
	}

	//echo("\$xml_url: |" . $xml_url . "|");
	//die();

	$pos = strpos($xml_url, "?");

	// Ha´ dois tipos de XML, as estaticas e as criadas dinamicamente
	// Dependendo dessas duas opcoes, escolhemos o a funcao para conseguir
	// o XML que e´ mais adequada:
	// XML estatico $server_action vem vazio e xml_url NAO contem o sinal '?' -> getXML($xml_url);
	// XML dinamico $server_action vem com o nome do script a ser
	//     executado no servidor ou o xml_url contem o sinal '?' -> document_post($xml_url);
	if ($server_action == "" and $pos === false )
	{
		// XML ESTATICO
		/* 
		echo("\$xml_url: |" . $xml_url . "|");
		die();
		*/
		$xml_content = getXML($xml_url);
	}
	else
	{
		// XML DINAMICO
		// percorre o vetor com as variaveis do request
		// Todas as variaveis que forem do tipo array,
		// sao variaveis da aplicacao servidora
		// (e´ uma suposicao desse sistema)
		$server_parameters = "";
		while (list($key_01, $value_01) = each($array_request_vars ))
		{
			if (is_array($value_01))
			{
				/* 
				echo("\$value_01: |" . $value_01 . "|");
				echo(NL); echo(NL);
				echo("\$value_01:" . NL);
				print_r($value_01);
				echo(NL); echo(NL);
				*/
				while (list($key_02, $value_02) = each($value_01))
				{
					$server_parameters .= "&" . $key_01 . "=" . urlencode($value_02);
				}
			}
		}
		
		if ($array_request_vars["lang"] != "" )
		{
			$lang = $array_request_vars["lang"];
		}
		else
		{
			$lang = "pt";
		}
		$server_parameters .= "&lang=" . $lang;
		
		/* */
		// No caso de querer voltar para o mesmo estado onde se encontra, levando
		// uma variavel de multiplos valores (um array que surge atravez de uma selecao
		// multipla - select), separamos esse valor atraves de pipes. No codigo abaixo
		// pegamos esse valor:
		if ($array_request_vars["YNG"] != "" and !(is_array($array_request_vars["YNG"])) )
		{
			$aux = $array_request_vars["YNG"];
			$aux = str_replace("|", "&YNG=", $aux);
			$server_parameters .= "&YNG=" . $aux;
		}
		if ($array_request_vars["CITED"] != "" and !(is_array($array_request_vars["CITED"])) )
		{
/*        
			$aux = $array_request_vars["CITED"];
			$aux = str_replace("|", "&CITED=", $aux);
			$server_parameters .= "&CITED=" . $aux;
*/            
			$aux = explode("|", $array_request_vars["CITED"]);
            for($i = 0; $i < count($aux); $i++)
            {
                $aux[$i] = urlencode($aux[$i]);
            }
			$server_parameters .= "&CITED=" . implode("&CITED=", $aux);
		}

    	if ($array_request_vars["issn"] != "")
	    {
		    $server_parameters .= "&issn=" . $array_request_vars["issn"];
    	}

		/*
		echo("\$server_parameters: |" . $server_parameters . "|");
		echo(NL); echo(NL);
		die();
		*/

		$host_server = $iniArr["hosts"]["server"];
		$xml_url = "http://" . $host_server . $server_action . "?formato=xml" . $server_parameters;
		/* 
		echo("\$xml_url:" . NL . $xml_url);
		die();
		*/
		$xml_content = document_post($xml_url);
	}

	$xml_content = trim($xml_content);
    //die($xml_content);
	//echo("\$xml_content: |" . $xml_content . "|");
	$xsl_path = $iniArr["xsl"]["getRoot"];
	//die("\$xsl_path: |" . $xsl_path . "|");

	if ($debug == "xml_01")
	{
		echo($xml_content);
		die();
	}
	//die($xml_content);
	$xml_node_content = transform($xml_content, $xsl_path);
	//die($xml_node_content);
	$xml_content = XML_HEADER . "<statistics>\n" . $xml_node_request_vars . $xml_node_ini . $xml_node_content . "\n</statistics>";
	//die($xml_content);
	$the_xsl = "xsl_" . $state;
	/* 
	echo("\$state: |" . $state . "|" . NL);
	echo("\$the_xsl: |" . $the_xsl . "|" . NL);
	die();
	*/
	
	$xsl_path = $iniArr["xsl"][$the_xsl];
	$html_content = transform($xml_content, $xsl_path);

	if ($debug == "xml")
	{
		echo($xml_content);
	}
	else
	{
		header("Content-Type:text/html; charset=iso-8859-1");
		echo($html_content);
	}

?>

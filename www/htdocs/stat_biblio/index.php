<?php 
ini_set("display_errors",'Off');
	include_once("functions.php");
	include_once("class.IniFile.php");
	include_once("class.RequestVars.php");
	require_once("class.SciELOInstances.php");

	
	$iniObj = new IniFile("ini/stat.ini");
	$iniArr = $iniObj->parse();
	$xml_node_ini =  $iniObj->getXML();
	$requestVars = new RequestVars();

	$pair_state_action = array("02"=>"","16"=>"", "17" => "7","03"=>"","15" => "1","04"=>"","05" => "1_2","18"=>"", "19" => "1_3","08"=>"3","07"=>"","09"=>"","10" => "6b","11"=>"","12" => "5b");

	$xml_node_request_vars = $requestVars->getVarsXml();
	$array_request_vars = $requestVars->getVarsArray();
	if ($array_request_vars['lang'] != 'en' && $array_request_vars['lang'] != 'es' && $array_request_vars['lang'] != 'pt'){
		$array_request_vars['lang'] = 'en';
	}
	
	$dateFile = dirname(__FILE__)."/../../scibiblio/bases/estat/artigo/artigoi.iy0";
	$xml_date = '<process-date>'.getLastProcessDate($dateFile, $array_request_vars['lang']).'</process-date>';


	$scieloInstanceId = $array_request_vars["country"];
	
	$scieloInstances = new SciELOInstances();
	if (!$scieloInstanceId || $scieloInstanceId=="" || !$scieloInstances->validateId($scieloInstanceId)) {
		$scieloInstanceId = $scieloInstances->getId($_SERVER['HTTP_REFERER']);
		if (!$scieloInstanceId  || $scieloInstanceId=="") {
			$scieloInstanceId = "org";
		}
	}
	if ($scieloInstanceId){
		$xml_instance  = '<instance id="'.$scieloInstanceId.'"><url>'.$scieloInstances->getURL($scieloInstanceId).'</url></instance>';
	}
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
	
	
	
	if ($array_request_vars["state"] != "" && array_key_exists($state, $pair_state_action))
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
		$xml_url = "http://" . $iniArr["hosts"]["server"] . $iniArr["hosts"]["static_xml"] . "/".$scieloInstanceId."/" . $state . ".xml";
	}
	
	
	$server_action = $pair_state_action[$state];
	
	if ($server_action != "")
	{
		if (strpos($server_action,'.sh')==0){		
			
			if (file_exists(dirname(__FILE__).'/../../cgi-bin/stat_biblio/xml/scielo'.$server_action.'.sh')){
				$server_action = '/cgi-bin/stat_biblio/xml/scielo'.$server_action.'.sh';
			}
		}
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
	if ($server_action == "" && $pos === false )
	{
		// XML ESTATICO
		/* 
		echo("\$xml_url: |" . $xml_url . "|");
		die();
		*/
		$xml_content = getXML($xml_url);
		if ($scieloInstanceId){
			$xml_content = str_replace('SciELO','SciELO '.$scieloInstances->getName($scieloInstanceId),$xml_content);
		}

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
					if (strpos(' '.$value_02,'/')>0 || strpos(' '.$value_02,'>')>0 || strpos(' '.$value_02,'<')>0){
						var_dump( $value_02);
					} else
					{
						$server_parameters .= "&" . $key_01 . "=" . urlencode($value_02);
					}										
				}
			}
		}
		
		
		$server_parameters .= "&lang=" . $array_request_vars['lang'] ;
		
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
    	if ($scieloInstanceId != "")
	    {
		$server_parameters .= "&country=" . $scieloInstanceId;
		}

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
	$xml_content = XML_HEADER . "<statistics>\n" .$xml_date. $xml_instance . $xml_node_request_vars . $xml_node_ini . $xml_node_content . "\n</statistics>";
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

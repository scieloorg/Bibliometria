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

    $xml_node_request_vars = $requestVars->getVarsXml();
	$array_request_vars = $requestVars->getVarsArray();


    /*
     * eliminar a passagem de parametros
     * server_action e xml
     * por motivo de seguranca
     *
     */
	$pair_state_action = array("02"=>"",
                                    "16"=>"",
                                    "17" => "7",
                                    "03"=>"",
                                    "15" => "1",
                                    "04"=>"",
                                    "05" => "1_2",
                                    "18"=>"",
                                    "19" => "1_3",
                                    "08"=>"3",
                                    "07"=>"",
                                    "09"=>"",
                                    "10" => "6",
                                    "11"=>"",
                                    "13" => "5out",
                                    "12" => "5");

	if ($array_request_vars["state"] != "" && array_key_exists($state, $pair_state_action))
	{
		$state = $array_request_vars["state"];
	}
	else
	{
		//echo("Warning: no state was defined, so default 02 is runing the business...");
		$state = "02";
	}



    /* tratamento de idioma */
	if ($array_request_vars['lang'] != 'en' && $array_request_vars['lang'] != 'es' && $array_request_vars['lang'] != 'pt'){
		$array_request_vars['lang'] = 'en';
	}

	/* obtencao da data de processamento */
	$dateFile =  file_get_contents(dirname(__FILE__).'./../../scibiblio/bases/estat/procdate.txt');
	$xml_date = '<process-date>'.getLastProcessDate($dateFile, $array_request_vars['lang']).'</process-date>';


    /* dados sobre a instancia */
	$scieloInstanceId = $array_request_vars["country"];	
	$scieloInstances = new SciELOInstances();
	if (!$scieloInstanceId || $scieloInstanceId=="" || !$scieloInstances->validateId($scieloInstanceId)) {
		$scieloInstanceId = $scieloInstances->getId($_SERVER['HTTP_REFERER']);
		if (!$scieloInstanceId  || $scieloInstanceId=="") {
			$scieloInstanceId = "org";
		}
	}
	if ($scieloInstanceId){
        $inst = $scieloInstances->getURL($scieloInstanceId);
        if (!$inst || $scieloInstanceId=='org') $inst = $iniArr['scieloorg']['url'];
		$xml_instance  = '<instance id="'.$scieloInstanceId.'"><url>'.$inst.'</url></instance>';
	}

    
    if ($state == "02" && $array_request_vars['issn']){
        $pageUrl = 'http://'.$inst.'/statjournal.php?lang='.$array_request_vars['lang'].'&issn='.$array_request_vars['issn'];
        $page = file_get_contents($pageUrl);

        if (!$page){
            $pageUrl = '?lang='.$array_request_vars['lang'].'&country='.$scieloInstanceId;
        }
        header('Location: '.$pageUrl);
        die();
    }
    /* com a inexistencia de xml e server_action ... */
	$server_action = $pair_state_action[$state];
	if ($server_action != "")
	{
        if ($array_request_vars['ng']=='b') {
            $server_action .= 'b';
        }
		if (strpos($server_action,'.sh')==0){		
			if (file_exists(dirname(__FILE__).'/../../cgi-bin/stat_biblio/xml/scielo'.$server_action.'.sh')){
				$server_action = '/cgi-bin/stat_biblio/xml/scielo'.$server_action.'.sh';
			}
		}
	}
    if ($server_action){
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

        if ($_GET['debug']=='yes'){
            var_dump($xml_url);
        }
		$xml_content = document_post($xml_url);
    }
	else
	{
		$xml_content = file_get_contents( "../" . $iniArr["hosts"]["static_xml"] . "/".$scieloInstanceId."/" . $state . ".xml");
		if ($_GET['debug']=='yes'){
            var_dump("../" . $iniArr["hosts"]["static_xml"] . "/".$scieloInstanceId."/" . $state . ".xml");
            var_dump($xml_content);
        }

	}
		

	$xml_content = trim($xml_content);
    if ($scieloInstanceId){
        $xml_content = str_replace('SciELO','SciELO '.$scieloInstances->getName($scieloInstanceId),$xml_content);
    }

	$xsl_path = $iniArr["xsl"]["getRoot"];
	if ($_GET['debug']=='yes'){
        var_dump($xsl_path);
        var_dump($xml_url);
        var_dump($xml_content);
    }
	$xml_node_content = transform($xml_content, $xsl_path);
	$xml_content = XML_HEADER . "<statistics>\n" .$xml_date. $xml_instance . $xml_node_request_vars . $xml_node_ini . $xml_node_content . "\n</statistics>";
	$the_xsl = "xsl_" . $state;
	
	$xsl_path = $iniArr["xsl"][$the_xsl];
    if ($_GET['debug']=='yes'){
        var_dump($xsl_path);
        var_dump($xml_url);
        var_dump($xml_content);
    }
	$html_content = transform($xml_content, $xsl_path);

	
    header("Content-Type:text/html; charset=iso-8859-1");
    echo($html_content);
	

?>

<?php
	class SciELOInstances {

		var $_instancesID ;
		var $_instancesURL ;
		var $_lang;

		function SciELOInstances($lang = 'en'){
			$this->_lang = $lang;
			$this->loadData($lang);
		}
		function loadData($lang){

			$lines = file (dirname(__FILE__).'./../../cgi-bin/stat_biblio/xml/lst_traduc.seq');
			$instancesURL["org"]['url'] = $_SERVER["SERVER_NAME"];
			$instancesURL["org"]['name'] = "SciELO Regional";

			foreach ($lines as $line_num => $line) {
				if ( strpos($line, "|pais|")>0 ||  strpos($line, "|temat|")>0  ) {
					$temp = explode('|',$line);
					$id = str_replace(chr(13),'',$temp[6]);
					$id = str_replace(chr(10),'',$id);
					$instances[$id] = $temp[4];
					$instancesURL[$temp[4]]['url'] = $id;
					if ($lang){
						switch ($lang){
							case "pt":
								$instancesURL[$temp[4]]['name'] = $temp[1];
								break;
							case "es":
								$instancesURL[$temp[4]]['name'] = $temp[2];
								break;
							case "en":
								$instancesURL[$temp[4]]['name'] = $temp[3];
								break;
						}
					}
					
					if (strpos($line,'scielo.br')>0) {
						$instances[str_replace('www.','www.homolog.',$id)] = $temp[4];
						$instances[str_replace('www.','www.dev.',$id)] = $temp[4];
					}
				}
			}
			

			$this->_instancesID = $instances;	
			$this->_instancesURL = $instancesURL;


		}

		function getId($referer){
			$referer = str_replace('http://','',$referer);
			$referer = str_replace('/','',$referer);
			return $this->_instancesID[$referer];

		}
		function getURL($id){
			return $this->_instancesURL[$id]['url'];
		}
		
		function getHTML_List_Citation(){
			$local = $this->_instancesURL["org"]['url'];
			foreach ($this->_instancesURL as $key => $inst) {

				$text .= '<li><a href="http://'.$local.'/stat_biblio/index.php?lang='.$this->_lang.'&country='.$key.'" target="_blank">'.$inst['name'].'</a></li>';
			}
			return $text;
		}
		function getHTML_List_CoAuthorship(){
			$local = $this->_instancesURL["org"]['url'];
			foreach ($this->_instancesURL as $key => $inst) {
				$text .= '<li><a href="http://'.$local.'/stat_biblio/index.php?lang='.$this->_lang.'&country='.$key.'&state=16" target="_blank">'.$inst['name'].'</a></li>';
			}
			return $text;
		}
		
		/*


require_once("/home/scieloorg/www/htdocs/stat_biblio/class.SciELOInstances.php");
$scieloInstances = new SciELOInstances($lang);
echo $scieloInstances->getHTMLList();

*/
	}
?>
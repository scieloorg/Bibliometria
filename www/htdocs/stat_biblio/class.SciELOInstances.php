<?php
	class SciELOInstances {

		var $_instancesID ;
		var $_instancesURL ;
		function SciELOInstances(){
			$this->loadData();
		}
		function loadData(){
			$lines = file ('../../cgi-bin/stat_biblio/xml/lst_traduc.seq');

			foreach ($lines as $line_num => $line) {
				if ( strpos($line, "|pais|")>0) {
					$temp = explode('|',$line);
					$id = str_replace(chr(13),'',$temp[6]);
					$id = str_replace(chr(10),'',$id);
					$instances[$id] = $temp[4];
					$instancesURL[$temp[4]] = $id;

					if (strpos($line,'scielo.br')>0) {
						$instances[str_replace('www.','www.homolog.',$id)] = $temp[4];
						$instances[str_replace('www.','www.dev.',$id)] = $temp[4];
					}
				}
			}
			$this->_instancesID = $instances;	
			$this->_instancesURL = $instancesURL;
var_dump($this->_instancesURL);
		}

		function getId($referer){
			$referer = str_replace('http://','',$referer);
			$referer = str_replace('/','',$referer);
			return $this->_instancesID[$referer];

		}
		function getURL($id){
			return $this->_instancesURL[$id];
		}
	}
?>
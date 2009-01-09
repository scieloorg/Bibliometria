<?php
 
//class.RequestVars.php
 
include_once("old2new.inc.php");
 
class RequestVars
{
	var $_request = array();
 
	function RequestVars()
	{
		global $HTTP_GET_VARS, $HTTP_POST_VARS;
		$this->_request = array_merge($HTTP_GET_VARS, $HTTP_POST_VARS);
	}
	 
	function getVarsArray()
	{
		return $this->_request;
	}
	 
	function getVarsXml()
	{
		$xml = "<request-vars>\n";
		if (is_array($this->_request))
		{
			$xml .= $this->recursiveXML($this->_request);
		}
		$xml .= "</request-vars>\n";
		return $xml;
	}
 
	function recursiveXML($arr)
	{
		$xml = "";
		while (list($key, $value) = each($arr))
		{
			if (is_numeric($key))
			{	
				// nao sei porque Shintani deixava o XML dessa forma, mudei para simplificar o processamento via XSL
				// $key = "__req_var__" . $key;
				$key = "var";
			}
			
			if (is_array($value))
			{
				$xml .= "<" . $key . ">\n";
				$xml .= $this->recursiveXML($value);
				$xml .= "</" . $key . ">\n";
			}
			else
			{
				$xml .= "<" . $key . ">" . stripcslashes(htmlspecialchars($value, ENT_NOQUOTES)) . "</" . $key . ">\n";
			}
		}
		return $xml;
	}
}
?>

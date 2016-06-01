<?php
	function clean($input, $type){
		switch($type){
			case "email":
				return filter_var($input, FILTER_SANITIZE_EMAIL);
				break;
			case "string":
				return filter_var($input, FILTER_SANITIZE_STRING);
				break;
			default:
				return filter_var($input, FILTER_SANITIZE_STRING);
				break;
		}
	}
?>
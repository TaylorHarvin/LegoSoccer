<?php
	// More secure seession generator
	function generateSession(){
		if (ini_set('session.use_only_cookies', 1) === FALSE) {
			header("Location: ../accessDenied.php");
			exit();
		}
		else{
			$cSettings = session_get_cookie_params();
			session_set_cookie_params($cSettings["lifetime"],$cSettings["path"],$cSettings["domain"],false,true);
			session_name("db_proj");
			session_start();
			session_regenerate_id(true);
		}
	}
	
?>
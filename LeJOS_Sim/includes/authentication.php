<?php
	// Basic authentication check
	if(!isset($_SESSION['username'])){
		header("location: http://localhost/knowledgerepo/login.php");
	}
?>